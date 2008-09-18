package Kynetx::Actions;
# file: Kynetx/Actions.pm

use strict;
use warnings;

use Log::Log4perl qw(get_logger :levels);
use Kynetx::Util qw(:all);
use Kynetx::JavaScript qw(:all);
use Kynetx::Rules qw(:all);

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Data::Dumper;
$Data::Dumper::Indent = 1;


our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (all => [ 
qw(
build_js_load
choose_action
eval_post_expr
get_precondition_test
get_precondition_vars
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;


my($active,$test,$inactive) = (0,1,2);

# TODO factor out common functionality in float and float2

# available actions
# should be a JS function; 
# mk_action will create a JS expression that applies it to appropriate arguments
# first arg MUST be uniq (a number unique to this rule action event)
# second arg MUST be cb (a callback function)
# note that $ is evaluated as a var indicator by perl in inlines.  Quote it.  
my %actions = (

    alert => <<EOF,
function(uniq, cb, msg) {alert(msg)}
EOF

#Actions::Alert::get_action(),

    redirect => 
      'function(uniq, cb, url) {window.location = url}',

    float_url => <<EOF,
function(uniq, cb, pos, top, side, url) {
    var vert = top.split(/\s*:\s*/);
    var horz = side.split(/\s*:\s*/);
    var div_style = \$H({
        position: pos,
        zIndex: '9999',
        opacity: 0.999999,
        display: 'none'
    });
    div_style.set(vert[0], vert[1]);
    div_style.set(horz[0], horz[1]);

    var id_str = 'kobj_'+uniq;
    var div2 = new Element('div');
    var div = new Element('div', {'id': id_str});
    div.setStyle(div_style.toObject());
    div.update(div2);
    document.body.appendChild(div);
    new Ajax.Updater(id_str, url, {
                     aynchronous: true,
                     method: 'get',
                     onComplete: cb
                     });
}
EOF


    float_html => <<EOF,
function(uniq, cb, pos, top, side, text) {
    var vert = top.split(/\s*:\s*/);
    var horz = side.split(/\s*:\s*/);
    var div_style = \$H({
        position: pos,
        zIndex: '9999',
        opacity: 0.999999,
        display: 'none'
    });
    div_style.set(vert[0], vert[1]);
    div_style.set(horz[0], horz[1]);

    var div2 = new Element('div');
    div2.update(text);

    var div = new Element('div', {'id': 'kobj_'+uniq});
    div.setStyle(div_style.toObject());
    div.update(div2);
    document.body.appendChild(div);
    cb();
}
EOF

    popup => <<EOF,
function(uniq, cb, top, left, width, height, url) {      
    var id_str = 'kobj_'+uniq;
    var options = 'toolbar=no,menubar=no,resizable=yes,scrollbars=yes,alwaysRaised=yes,status=no' +
                 'left=' + left + ', ' +
                 'top=' + top + ', ' +
                 'width=' + width + ', ' +
                 'height=' + height;
    open(url,id_str,options);
    cb();
}
EOF

    replace_url => <<EOF,
function(uniq, cb, id, url) {
   id = \$(id);
   new Ajax.Updater(id, url, {
                    aynchronous: true,
                    method: 'get' ,
                    onComplete: cb
                    });   
   new Effect.Appear(id);
}
EOF

    replace_html => <<EOF,
function(uniq, cb, id, text) {
 var div = document.createElement('div');
 div.setAttribute('style', 'display: none');
 div.innerHTML = text;
 id = \$(id);
 id.replace(div);
 new Effect.BlindDown(div, {duration: 1.0});
 cb();
}
EOF

    move_after => <<EOF,
function(uniq, cb, anchor, item) {
  var c = \$(item);
  c.remove();
  \$(anchor).insert({top: c})
}
EOF

    move_to_top => <<EOF,
function(uniq, cb, li) {
    var c = \$(li);
    var t = c.up();
    c.remove();
    t.insert({top: c})
}
EOF


    log_callback => <<EOF,
function(uniq, cb, ) {
    KOBJ.logger("click",
		txn_id,
		name, 
	        '', 
		sense,
		rule
	);
    false;
EOF

);


# function names in this hash indicate if the function is modifiable
my %modifiable = (
    'float_url' => 1,
    'float_html' => 1
    );



sub build_js_load {
    my ($rule, $req_info, $rule_env, $session) = @_;

    my $logger = get_logger();

    # rule id
    my $uniq = int(rand 999999999);
    my $uniq_id = 'kobj_'.$uniq; 


    $rule_env->{'uniq_id'} = $uniq_id;


    # this loads the rule_env
    gen_js_pre($req_info, $rule_env, $rule->{'name'}, $session, $rule->{'pre'});


    my $js = "";

    
    # set JS vars from rule env
    my $rulename_re = qr/^$rule->{'name'}:(.*)/;
    foreach my $var ( keys %{ $rule_env} ) {
	my $val = $rule_env->{$var};
	next unless $var =~ s/$rulename_re/$1/;
	$logger->debug("[JS var] ", $var, "->", $val);
	$js .= "var $var = \'" . $val . "\';\n";

    }



    # callbacks
    my $cb = '';
    if($rule->{'callbacks'}) {
	foreach my $sense ('success','failure') {
	    $cb .= gen_js_callbacks($rule->{'callbacks'}->{$sense},
				    $req_info->{'txn_id'},
		                    $sense,
				    $rule->{'name'}
		                   );
	}
    }
    
    my $cb_func_name = 'callBacks'.$uniq;
    $js .= gen_js_mk_cb_func($cb_func_name,$cb);


    my $action_num = int(@{ $rule->{'actions'} });

    $logger->debug('blocktype is ' . $rule->{'blocktype'});
    $logger->debug("actions list contains $action_num actions");
    if ($rule->{'blocktype'} eq 'every') {
	# generate JS for every action
	foreach my $action_expr (@{ $rule->{'actions'} }) {
	    # tack on this loop's js
	    $js .= build_one_action($action_expr, 
				    $req_info, 
				    $rule_env, 
				    $session,
				    $uniq,
				    $uniq_id,
				    $cb_func_name,
				    $rule->{'name'}
		);
	}

    } elsif ($rule->{'blocktype'} eq 'choose') {
	# choose one action at random
	my $choice = int(rand($action_num));
	$logger->debug("chose $choice of $action_num");
	$js .= build_one_action($rule->{'actions'}->[$choice], 
				$req_info, 
				$rule_env, 
				$session,
				$uniq,
				$uniq_id,
				$cb_func_name,
				$rule->{'name'}
	    );

    } else {
	$logger->debug('bad blocktype');
    }

    return $js;

}


sub build_one_action {
    my ($action_expr, $req_info, $rule_env, $session, 
	$uniq, $uniq_id, $cb_func_name, $rule_name) = @_;

    my $logger = get_logger();


    my $js = '';

    my $action = $action_expr->{'action'};
    my $action_name = $action->{'name'};

    my $args = $action->{'args'};

    # process overloaded functions and arg reconstruction
    ($action_name, $args) = 
	choose_action($req_info, $action_name, $args, $rule_env, $rule_name);

    # this happens after we've chosen the action since it modifies args
    $args = gen_js_rands( $args );

    # add to front of arg str
    unshift @{ $args }, $cb_func_name;
    unshift @{ $args }, mk_js_str($uniq);

    # create comma separated list of arguments 
    my $arg_str = join(',', @{ $args }) || '';

    $logger->debug("[action] ", $action_name, 
		   ' executing with args (',$arg_str,')');

    # apply the action function
    $js .= "(". $actions{$action_name} . "(" . $arg_str . "));\n";

    push(@{ $rule_env->{'actions'} }, $action_name);


    # set defaults
    my %mods = (
	delay => 0,
	effect => 'appear',
	scrollable => 0,
	draggable => 0,
	);

    # override defaults if set
    foreach my $m ( @{ $action->{'modifiers'} } ) {
	$mods{$m->{'name'}} = gen_js_expr($m->{'value'});
    }


    if($modifiable{$action_name}) {
	# map our effect names to Sript.taculo.us effect names

	my $effect_name;
        case: for ($mods{'effect'}) {
	    /appear/ && do {
		$effect_name = 'Appear';
	    };
	    /slide/ && do {
		$effect_name = 'SlideDown';
	    };
	    /blind/ && do {
		$effect_name = 'BlindDown';
	    };
	}


	$logger->debug("Using effect $effect_name for $mods{'effect'}");
	$js .= "new Effect.$effect_name('$uniq_id');"  ;

	if($mods{'draggable'} eq 'true') {
	    $js .= "new Draggable('". $uniq_id . "', '{ zindex: 99999 }');";
	}
	
	if($mods{'scrollable'} eq 'true') {
	    $js .= "new FixedElement('". $uniq_id . "');";
	}

    } elsif($action_name eq "popup") {
	if ($mods{'effect'} eq 'onpageexit') {
	    # FIXME: use a Prototype Effect here, if we can
	    my $funcname = "leave_" . $uniq_id;
	    $js = "function $funcname () { " . $js . "};\n";
	    $js .= "document.body.setAttribute('onUnload', '$funcname()');"
	}
    }

	
    if($mods{'delay'}) {
	# these ought to be pre-compiled on the rules
	$js =~ y/\n\r//d; # remove newlines
	$js =~ y/ //s;
	$js =~ s/'/\\'/g; # escape single quotes
	$js = "setTimeout(\'" . $js . "\', " . ($mods{'delay'} * 1000) . ");";
    }

    push(@{ $rule_env->{'tags'} }, ($mods{'tags'} || ''));
    push(@{ $rule_env->{'labels'} }, $action_expr->{'label'} || '');

#	$logger->debug(Dumper($rule_env));

    return $js;
}


# some actions are overloaded depending on the args.  This function chooses 
# the right JS function and adjusts the arg string.
sub choose_action {
    my($req_info,$action_name,$args,$rule_env,$rule_name) = @_;
    my $logger = get_logger();

    my $action_suffix = "_url";

    if($action_name eq 'float' || $action_name eq 'replace') {

	my $last_arg = pop @$args;

	my $url = gen_js_expr($last_arg);
	$url =~ s/'([^']*)'/$1/;

	$logger->debug("URL: ", $url);

	my $parsed_url = APR::URI->parse($req_info->{'pool'}, $url);
	my $parsed_caller = APR::URI->parse($req_info->{'pool'}, $req_info->{'caller'});

	# URL not relative and not equal to caller
	if ($parsed_url->hostname && 
	    ($parsed_url->hostname ne $parsed_caller->hostname ||
	     $parsed_url->port ne $parsed_caller->port ||
	     $parsed_url->scheme ne $parsed_caller->scheme)
	    ) {

	    $logger->debug("[action] URL domain is ", $parsed_url->hostname, 
			   " & caller domain is ", $parsed_caller->hostname
		);

	    $action_suffix = "_html";


#	    $logger->debug("Rule env: ", Dumper($rule_env));
	    
	    # We need to eval the argument since it might be an expression
	    $url = gen_js_expr(
		    eval_js_expr($last_arg, $rule_env, $rule_name));
	    $url =~ s/^'(.*)'$/$1/;
	    $logger->debug("Fetching ", $url);

	    # FIXME: should be caching this...
	    my $content = LWP::Simple::get($url);
	    $content =~ y/\n\r/  /; # remove newlines
	    $last_arg =  Kynetx::Parser::mk_expr_node('str',$content);
	    #$logger->debug("Last arg: ", Dumper($last_arg));
	    
	} 

	push @{ $args }, $last_arg;
    	$action_name = $action_name . $action_suffix;
    }

    $logger->debug("[action] $action_name with ", join(", ", Dumper(@{$args})));

    return ($action_name, $args);
}



sub eval_post_expr {
    my($expr, $session) = @_;

    my $logger = get_logger();
    $logger->debug("[post] ", $expr->{'type'});

    my $js = '';
    case: for ($expr->{'type'}) {
	/clear/ && do { 
	    if(exists $expr->{'counter'}) {
		delete $session->{$expr->{'name'}};
		delete $session->{mk_created_session_name($expr->{'name'})}
	    }
	    return $js;
	};
	/iterator/ && do {
	    if(exists $expr->{'counter'}) {
		if(exists $session->{$expr->{'name'}}) {
		    $session->{$expr->{'name'}} += $expr->{'value'};
		    $logger->debug("[post] iterating counter ",  
				   $expr->{'name'},
				   " by ",
				   $expr->{'value'});

		} else {
		    $session->{$expr->{'name'}} = $expr->{'from'};
		    $session->{mk_created_session_name($expr->{'name'})} = 
			# use DateTime for consistency 
			DateTime->now->epoch;
		    $logger->debug("[post] initializing counter ",  
				   $expr->{'name'},
				   " to ",
				   $expr->{'from'});
		}
	    }
	    return $js;
	};

	/callbacks/ && do {

	    foreach my $cb (@{$expr->{'callbacks'}}) {
		my $t = $cb->{'value'};
		my $a = $cb->{'attribute'};
		$session->{$t} = 1;
		$logger->debug("[post] Setting callback named $a = $t");
		if($a eq 'id') {
		    $js .= <<EJS;
var e_$t = document.getElementById('$t');  
Event.observe(e_$t, "click", function() {KOBJ.logger("$t")});
EJS
		} elsif ($a eq 'class') {
		    $js .= <<EJS1;
var e_$t = document.getElementsByClass('$t');  
e_$t.each(function (c) {
    Event.observe(c, "click", function() {KOBJ.logger("$t")})});
EJS1
	        } 
	    }
	    return $js;
	};
    }

}


sub get_precondition_test {
    my $rule = shift;

    $rule->{'pagetype'}{'pattern'};
}

sub get_precondition_vars {
    my $rule = shift;

    $rule->{'pagetype'}{'vars'};
}


1;
