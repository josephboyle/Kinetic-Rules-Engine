{"global":[],"global_start_line":19,"dispatch":[],"dispatch_start_col":3,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"raise_event","args":[{"val":"testevent","type":"str"}],"modifiers":[{"value":{"val":[{"rhs":{"val":"bbb","type":"str"},"lhs":"aaa"},{"rhs":{"val":"dddd","type":"str"},"lhs":"ccc"}],"type":"hashraw"},"name":"parameters"},{"value":{"val":"a685x6","type":"str"},"name":"app_id"}],"vars":null},"label":null}],"post":null,"pre":null,"name":"first_rule","start_col":4,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"domain":null,"pattern":".*","type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":23},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"third_rule","type":"str"},{"val":"third_rule","type":"str"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":null,"name":"third_rule","start_col":6,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"domain":"web","type":"prim_event","vars":[],"filters":[],"op":"cidtest"},"foreach":[]},"start_line":30}],"meta_start_col":3,"meta":{"logging":"off","name":"RaiseEvent","meta_start_line":2,"author":"","description":"","meta_start_col":3},"dispatch_start_line":13,"global_start_col":3,"ruleset_name":"a685x5"}
