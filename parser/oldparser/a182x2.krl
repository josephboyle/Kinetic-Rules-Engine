{"global":[],"global_start_line":null,"dispatch":[{"domain":"www.google.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"my_select","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"newrule","start_col":5,"emit":"function my_select(obj) {  \tvar ftext = $K(obj).text();  \tif (ftext.match(/the tick/)) {  \t  return \"<span><strong>Test is working!</strong></span>  \t} else {  \t  false;  \t}  }            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":12}],"meta_start_col":5,"meta":{"logging":"off","name":"search","meta_start_line":2,"description":"search anotation   \n","meta_start_col":5},"dispatch_start_line":9,"global_start_col":null,"ruleset_name":"a182x2"}
