// primrule with label
ruleset 10 {


  rule test_every is inactive {
    select using "/identity-policy/" setting ()

    pre {
    }

    label1:
       replace("kobj_test", "/kynetx/newsletter_invite_1.inc")
	   with tags = ["gift certificate", "yellow"] and
	        delay = 30;


  }



}
