package Kynetx::Dispatch;
# file: Kynetx/Dispatch.pm
#
# This file is part of the Kinetic Rules Engine (KRE)
# Copyright (C) 2007-2011 Kynetx, Inc. 
#
# KRE is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#
use strict;
#use warnings;

use Log::Log4perl qw(get_logger :levels);

use JSON::XS;
use Test::Deep::NoTest qw(cmp_set eq_deeply set);


use Kynetx::Rids qw/:all/;
use Kynetx::Memcached qw/:all/;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (all => [ 
qw(
simple_dispatch
extended_dispatch
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;

use Data::Dumper;


sub simple_dispatch {
    my($req_info, $rids) = @_;

    my $logger = get_logger();
    $logger->debug("Returning dispatch sites for $rids");

    my $r = {};

    my @rids = split(/;/,$rids);
    

    foreach my $rid (@rids) {

      my $rid_info = mk_rid_info($req_info, $rid);

      my $ruleset = Kynetx::Repository::get_rules_from_repository($rid_info, $req_info);


      if( defined $ruleset && $ruleset->{'dispatch'} ) {
	    $logger->debug("Processing dispatch block for $rid");
#	    $logger->debug(sub() {Dumper($ruleset->{'dispatch'})});
	    $r->{$rid} = [];
	    foreach my $d (@{ $ruleset->{'dispatch'} }) {
	      push(@{ $r->{$rid} }, $d->{'domain'});
	    }
	}    
    }

#    $logger->debug(Dumper $r);

    $r = encode_json($r);
#    $logger->debug($r);

    return $r;

}

sub extended_dispatch {
    my($req_info) = @_;

    my $r = calculate_dispatch($req_info);

    delete $r->{'event_rids'}; # doesn't belong in the dispatch API return result
    delete $r->{'events'}; # doesn't belong in the dispatch API return result
    $r = encode_json($r);

    # my $logger = get_logger();
    # $logger->debug($r);

    return $r;

}

sub calculate_rid_list {
  my($req_info, $session) = @_;

  my $rids = $req_info->{'rids'};

  my $logger = get_logger();
  $logger->debug("Returning ruleset list for ", $req_info->{'domain'},"/",$req_info->{'eventtype'});

  my $id_token = $req_info->{'id_token'};

  unless (defined $id_token) {
    $logger->debug("No ID token, returning empty rid_list");
    return {};
  }

  my $r = {};

  if (is_eventtree_stashed($req_info)) { 
    $logger->debug("Using stashed eventtree");
    $r = grab_eventtree($req_info);
  } else {
    my $ken = Kynetx::Persistence::get_ken($session, "", "web"); # empty rid

    my $memd = get_memd();
    my $rid_list_key = mk_ridlist_key($ken);

    my $rid_list = $memd->get($rid_list_key);


    if ($rid_list) { 
      $logger->debug("Using cached rid_list ", rid_info_string($rid_list));

    } else {
      # get accout info
      my $user_rids_info = Kynetx::Configure::get_config('USER_RIDS_URL');
      my ($app_url,$username,$passwd) = split(/\|/, $user_rids_info);
      my $acct_url = $app_url."/".$req_info->{'id_token'};
#      $logger->debug("Using ridlist URL: $acct_url");
      my $req = HTTP::Request->new(GET => $acct_url);
      $req->authorization_basic($username, $passwd);
      my $ua = LWP::UserAgent->new;
      my $response = decode_json($ua->request($req)->{'_content'});
      if ($response->{'validtoken'}) {
	$rid_list = $response->{'rids'};

	$logger->debug("Retrieved rid_list: ", print_rids($rid_list));

	# cache this...
	$memd->set($rid_list_key, $rid_list) ;
      } else {
	$logger->debug("Invalid token: $req_info->{'id_token'}. No RID list retrieved");	
      }
     
    }

    my $eventtree_key = mk_eventtree_key($rid_list);

    #  $r = $memd->get($eventtree_key);

    foreach my $rid_info (@{$rid_list}) {

      my $rid = get_rid($rid_info);

      my $ruleset = Kynetx::Repository::get_rules_from_repository($rid_info, $req_info, $rid_info->{'kinetic_app_version'});

  
      my $dispatch_info = process_dispatch_list($rid, $ruleset);
#      $logger->debug("Domain ", sub{ Dumper $dispatch_info } );
      foreach my $d ( @{ $dispatch_info->{'domains'} }) {
      	$r->{'ridlist'}->{$rid}->{'domains'}->{$d} = 1;
      }


      foreach my $d ( keys %{$ruleset->{'rule_lists'} }) {
	foreach my $t ( keys %{$ruleset->{'rule_lists'}->{$d} } ) {
	  push(@{$r->{$d}->{$t}}, $rid_info);
	}
      }
    }
    $logger->debug("Calculating and stashing the event tree");

#    $logger->debug("Event Tree: ", sub { Dumper $r });

    # cache this...
#    $memd->set($eventtree_key, $r);

     stash_eventtree($req_info, $r);

  }

  return $r;
}

sub clear_rid_list {
  my($session) = @_;
  my $logger = get_logger();
  $logger->debug("[flush] flushing RID list for ",Kynetx::Session::session_id($session));
  my $ken = Kynetx::Persistence::get_ken($session, "", "web");
  my $memd = get_memd();
  $memd->delete(mk_ridlist_key($ken));
}
    

sub calculate_dispatch {

  my($req_info) = @_;

  my $rids = $req_info->{'rids'};

  my $logger = get_logger();
  $logger->debug("Returning dispatch sites for ", Kynetx::Rids::print_rids($rids));

  my $r = {};
  $r->{'event_rids'} = {};
  $r->{'events'} = {};

#  my @rids = split(/;/,$rids);
    
  foreach my $rid_info (@{$rids}) {

    my $rid = get_rid($rid_info);

    my $ruleset = Kynetx::Repository::get_rules_from_repository($rid_info, $req_info, $rid_info->{'kinetic_app_version'});

    $r->{$rid} = process_dispatch_list($rid, $ruleset);


    foreach my $d ( keys %{$ruleset->{'rule_lists'} }) {
      foreach my $t ( keys %{$ruleset->{'rule_lists'}->{$d} } ) {
	push(@{$r->{'event_rids'}->{$d}->{$t}}, $rid);
	if (defined $ruleset->{'rule_lists'}->{$d}->{$t}->{'filters'}) {
	  $r->{$rid}->{'events'}->{$d}->{$t} = 
	    $ruleset->{'rule_lists'}->{$d}->{$t}->{'filters'};
	  # we only want the patterns if they aren't there already
	  foreach my $p ( @{ $ruleset->{'rule_lists'}->{$d}->{$t}->{'filters'} } ) {
	    if (!defined $r->{'events'}->{$d}->{$t}) {
	      #		    $logger->debug("Adding ($d, $t) ", Dumper $p);
	      $r->{'events'}->{$d}->{$t} = [$p];
	    } else {
	      if (!deep_member($p, $r->{'events'}->{$d}->{$t})) {
		#		      $logger->debug("Was ($d, $t)", Dumper $r->{'events'}->{$d}->{$t});
		push(@{$r->{'events'}->{$d}->{$t}},
		     $p
		    );	
		#		      $logger->debug("Now ($d, $t)", Dumper $r->{'events'}->{$d}->{$t});
	      }
	    }
	  }
	}
      }
    }
  }
  return $r;
}

sub deep_member {
  my($element, $array) = @_;
  my $result = 0;
  foreach my $e ( @{$array} ) {
    if (eq_deeply($element, $e)) {
      $result = 1;
    }
  }
  return $result;
}

sub process_dispatch_list {
  my($rid,$ruleset) = @_;
  my $logger = get_logger();
  # $logger->debug("Processing dispatch information for $rid");

  my $r = {};
  if( defined $ruleset && $ruleset->{'dispatch'} ) {
    $logger->debug("Processing dispatch block for $rid");
    #	    $logger->debug(sub() {Dumper($ruleset->{'dispatch'})});
    foreach my $d (@{ $ruleset->{'dispatch'} }) {
      #	      $logger->debug("Seeing ", sub{Dumper $d});
      if (defined $d->{'domain'}) {
	push(@{ $r->{'domains'} }, $d->{'domain'});
      } elsif (defined $d->{'iframe'}) {
	push(@{ $r->{'iframes'} }, $d->{'iframe'});
      } 
    }
  }   
  return $r;

}

sub flatten_event_expr {
  my($expr) = @_;

  if ($expr->{'type'} eq 'prim_event') {
    return [$expr];
  } elsif ($expr->{'type'} eq 'complex_event') {

    my @args = ($expr->{'op'} eq 'notbetween' ||
		$expr->{'op'} eq 'between') ? 
	  ($expr->{'first'}, $expr->{'mid'}, $expr->{'last'}) :
	  @{ $expr->{'args'} } ;
    my @r;
    foreach my $a (@args) {
       push @r,  @{flatten_event_expr($a)};
    }
    return \@r;
  }

}

sub get_domain {
  my($expr) = @_;

  if (ref $expr eq 'HASH' && defined $expr->{'domain'}) {
    return $expr->{'domain'};
  } else {
    return 'web';
  }
}

sub get_dispatch_info {
  my($expr) = @_;

  my $logger = get_logger();
  $logger->debug("Expr is a ", sub {Dumper $expr});
  
  return {'hello' => 'world'} unless (ref $expr eq 'HASH');
  if ($expr->{'op'} eq 'pageview') {
    return {'pattern' => $expr->{'pattern'},
	    'type' => $expr->{'op'}};
  } elsif ($expr->{'op'} eq 'submit' ||
	   $expr->{'op'} eq 'change' ||
	   $expr->{'op'} eq 'click'
	  ) {
    return {'elem' => $expr->{'elem'},
	    'type' => $expr->{'op'}};
  } else {
    return {};
  }
}

sub mk_ridlist_key {
  my ($id_token) = @_;
  return "ridlist:$id_token";
}

sub mk_eventtree_key {
  my ($rid_list) = @_;
  return Digest::MD5::md5_hex(rid_info_string($rid_list));
}

sub stash_eventtree {
	my ( $req_info, $eventtree ) = @_;
	$req_info->{"KOBJ.eventtree"} = $eventtree;
}

sub grab_eventtree {
	my ( $req_info ) = @_;
	return $req_info->{"KOBJ.eventtree"};
}

sub is_eventtree_stashed {
	my ( $req_info ) = @_;
	return defined $req_info->{"KOBJ.eventtree"};
}



1;
