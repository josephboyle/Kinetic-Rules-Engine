{"global":[{"source":"http://technologyforlearning.dabbledb.com/publish/technologyforlearning/ae3dec69-f428-43c7-beda-d421a5a6d296/lastreviewed.jsonp","name":"dabble","type":"dataset","datatype":"JSON","cachable":{"period":"minutes","value":"60"}}],"global_start_line":13,"dispatch":[{"domain":"technologyforlearning.info","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Welcome","type":"str"},{"val":"In #{episode} we reviewed #{app}.","type":"str"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"dabble","type":"var"},"args":[{"val":"$..entries[0].fields[0].value","type":"str"}],"name":"pick","type":"operator"},"lhs":"app","type":"expr"},{"rhs":{"obj":{"val":"dabble","type":"var"},"args":[{"val":"$..entries[0].fields[1].value","type":"str"}],"name":"pick","type":"operator"},"lhs":"episode","type":"expr"}],"name":"show_stuff","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http:\\/\\/technologyforlearning.info","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":16}],"meta_start_col":5,"meta":{"logging":"off","name":"test_dabble","meta_start_line":2,"author":"Michael Farmer","description":"Testing dabbledb as a dataset     \n","meta_start_col":5},"dispatch_start_line":10,"global_start_col":5,"ruleset_name":"a18x4"}
