{"global":[],"global_start_line":null,"dispatch":[],"dispatch_start_col":null,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"newrule","start_col":5,"emit":"function testBook() {          var imageHere = $K(\"img\").attr(\"src\");          toAppend = \"<a href='\" + imageHere + \"'>Click here to view the above image</a>\";        $K(this).append(\"HELLO!\");        console.log(\"Appended: \", toAppend);    }            $K(\"img\").load(testBook);              ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"books.google.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":9}],"meta_start_col":5,"meta":{"logging":"off","name":"Google Print","meta_start_line":2,"description":"Allows you to save images from Google Print (Books)   \n","meta_start_col":5},"dispatch_start_line":null,"global_start_col":null,"ruleset_name":"a41x15"}
