{"global":[],"global_start_line":null,"dispatch":[{"domain":"espn.go.com","ruleset_id":null},{"domain":"sports.espn.go.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"body","type":"str"},{"val":"<div style='position: absolute; top: 10px; right: 10px; z-index:2'><table><tr><td><img src='http://assets.espn.go.com/i/teamlogos/ncaa_conf/lrg/sec.gif' alt='Southeastern Conference ' title='Southeastern Conference ' valign='top' /></td></tr><tr><td><h1>SEC Football</h1></td></tr><tr><td>\t<span><a href='http://sports.espn.go.com/ncf/conference?confId=8'>Index</a> | <a href='http://sports.espn.go.com/ncf/scoreboard?confId=8'>Scores</a> </span></td></tr><tr><td> <span> <a href='http://sports.espn.go.com/ncf/conferences/standings?confId=8'>Standings</a> | <a href='http://sports.espn.go.com/ncf/statistics?group=8'>Statistics</a></span></td></table></div>","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"espn","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://espn.go.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":10},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"body","type":"str"},{"val":"<div style='position: absolute; top: 10px; right: 10px; z-index:2'><table><tr><td><img src='http://assets.espn.go.com/i/teamlogos/ncaa_conf/lrg/sec.gif' alt='Southeastern Conference ' title='Southeastern Conference ' valign='top' /></td></tr><tr><td><h1>SEC Football</h1></td></tr><tr><td>\t<span><a href='http://sports.espn.go.com/ncf/conference?confId=8'>Index</a> | <a href='http://sports.espn.go.com/ncf/scoreboard?confId=8'>Scores</a> </span></td></tr><tr><td> <span> <a href='http://sports.espn.go.com/ncf/conferences/standings?confId=8'>Standings</a> | <a href='http://sports.espn.go.com/ncf/statistics?group=8'>Statistics</a></span></td></table></div>","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"sports_espn","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://sports.espn.go.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":15}],"meta_start_col":5,"meta":{"logging":"off","name":"SEC Fan","meta_start_line":2,"meta_start_col":5},"dispatch_start_line":6,"global_start_col":null,"ruleset_name":"a111x8"}
