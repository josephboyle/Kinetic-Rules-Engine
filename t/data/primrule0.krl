// primrule no label
ruleset 10 {


  // rule for testing every
  rule test_every is inactive {
    select using "/identity-policy/" setting ()

    pre {
    }

    replace("kobj_test", "/kynetx/newsletter_invite_1.inc")
	   with tags = ["gift certificate", "yellow"] and
	        delay = 30;


  }



}
