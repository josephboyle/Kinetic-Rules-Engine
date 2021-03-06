#!/usr/bin/perl -w 
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
use lib qw(/web/lib/perl);
use strict;
use warnings;

use Test::More;
use Test::LongString;

use Apache::Session::Memcached;
use DateTime;
use APR::URI;
use APR::Pool ();
use Cache::Memcached;


# most Kyentx modules require this
use Log::Log4perl qw(get_logger :levels);
Log::Log4perl->easy_init($INFO);
#Log::Log4perl->easy_init($DEBUG);
my $logger = get_logger();

use Kynetx::Test qw/:all/;
use Kynetx::Scheduler qw/:all/;
use Kynetx::Environments qw/:all/;
use Kynetx::Session qw/:all/;
use Kynetx::Configure qw/:all/;
use Kynetx::FakeReq qw/:all/;

use Data::Dumper;
$Data::Dumper::Indent = 1;


my $r = Kynetx::Test::configure();

my $rid = 'cs_test';

# test choose_action and args

my $req_info_1 = Kynetx::Test::gen_req_info('1');
my $req_info_2 = Kynetx::Test::gen_req_info('2');
my $req_info_3 = Kynetx::Test::gen_req_info('3');

my $rule_name = 'foo';

my $rule_env = Kynetx::Test::gen_rule_env();

my $session = Kynetx::Test::gen_session($r, $rid);

my $test_count = 0;


my $schedule = Kynetx::Scheduler->new();

$schedule->add('1', 
	       {'name' => 'rule_1_1'}, 
	       {'rid' => '1'},
	      );

$schedule->add('1', 
	       {'name' => 'rule_1_2'}, 
	       {'rid' => '1'},
	       {'num' => 'ONE'}
	      );
	      
$schedule->add('1', 
	       {'name' => 'rule_1_2'}, 
	       {'rid' => '1'},
	       {'num' => 'TWO'}
	      );

#diag Dumper $schedule;

$schedule->add('2', 
	       {'name' => 'rule_2_1'}, 
	       {'rid' => '2'},
	      );

$schedule->add('3', 
	       {'name' => 'rule_3_1'}, 
	       {'rid' => '3'},
	       {'num' => 'ALPHA'}
	      );
	      
$schedule->add('3', 
	       {'name' => 'rule_3_1'}, 
	       {'rid' => '3'},
	       {'num' => 'BRAVO'}
	      );
	      
$schedule->add('3', 
	       {'name' => 'rule_3_1'}, 
	       {'rid' => '3'},
	       {'num' => 'CHARLIE'}
	      );

$schedule->add('3', 
	       {'name' => 'rule_3_2'}, 
	       {'rid' => '3'},
	      );

$schedule->add('3', 
	       {'name' => 'rule_3_3'}, 
	       {'rid' => '3'},
	      );





my $rl = []; 
while (my $task = $schedule->next()) {
	$logger->debug("Task: ",sub {Dumper($task)});
    push(@{ $rl }, $task->{'rule'}->{'name'});	
}

$logger->debug("Rule list: ",sub {Dumper($rl)});

$test_count++;

is_deeply($rl, 
	  [ 'rule_1_1',
  		'rule_1_2',
  		'rule_1_2',
  		'rule_2_1',
  		'rule_3_1',
  		'rule_3_1',
  		'rule_3_1',
  		'rule_3_2',
  		'rule_3_3'
	  ]
	 );


done_testing($test_count);



1;


