{"global":[],"global_start_line":null,"dispatch":[{"domain":"google.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"popup","args":[{"val":200,"type":"num"},{"val":200,"type":"num"},{"val":800,"type":"num"},{"val":800,"type":"num"},{"val":"http://www.amazon.com","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"popup","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"google.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":9},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Fail Not!","type":"str"},{"val":"If you can see this, the popup rule caused no fail.","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"notify","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"google.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":14}],"meta_start_col":5,"meta":{"logging":"off","name":"Popup Fail","meta_start_line":2,"meta_start_col":5},"dispatch_start_line":6,"global_start_col":null,"ruleset_name":"a41x31"}
