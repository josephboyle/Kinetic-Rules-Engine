{"global":[{"source":"http://search.twitter.com/search.json","name":"twitter_search","type":"datasource","datatype":"JSON","cachable":0},{"content":"#kynetx_twitter_results {\n            border: 1px solid black;\n            background-color: whitesmoke;\n            padding: 10px;\n            padding-top: 20px;\n            width: 500px;\n          }\n          \n          #kynetx_twitter_results img {\n            display: block;\n            float: right;\n            width: 18px;\n            height: 18px;\n          }\n          \n          .tweet {\n            color: white;\n            border: 1px solid black;\n            background-color: #3F3F3F;\n            margin: 5px;\n            padding: 10px;\n            width: 470px;\n            height: 45px;\n            -moz-border-radius: 5px; /* FF1+ */\n            -webkit-border-radius: 5px; /* Saf3+, Chrome */\n          }\n          \n          .tweet img {\n            width: 30px !important;\n            height: 30px !important;\n          }\n        \n        ","type":"css"}],"global_start_line":19,"dispatch":[{"domain":"www.google.com","ruleset_id":null}],"dispatch_start_col":1,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"after","args":[{"val":"#ssb","type":"str"},{"val":"twitter_results_div","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":"<div id=\"kynetx_twitter_results\">\n            Twitter Search Results:\n            <div id=\"kresults\"></div>          \n          </div>\n        \n        ","lhs":"twitter_results_div","type":"here_doc"}],"name":"create_display_area","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"domain":null,"pattern":"www.google.com/search.*","type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":60},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#kresults","type":"str"},{"val":"tweet_div","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"tweet","type":"var"},"args":[{"val":"$..text","type":"str"}],"name":"pick","type":"operator"},"lhs":"text","type":"expr"},{"rhs":{"obj":{"val":"tweet","type":"var"},"args":[{"val":"$..profile_image_url","type":"str"}],"name":"pick","type":"operator"},"lhs":"picture","type":"expr"},{"rhs":"<div class=\"tweet\"><img src=\"#{picture}\" />#{text}</div>\n     ","lhs":"tweet_div","type":"here_doc"}],"name":"first_rule","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.google.com/search.*(?:&q|\\?q)=([^&]*)","legacy":1,"type":"prim_event","vars":["term"],"op":"pageview"},"foreach":[{"expr":{"obj":{"source":"datasource","predicate":"twitter_search","args":[{"args":[{"val":"?q=","type":"str"},{"obj":{"val":"term","type":"var"},"args":[{"val":"/ /g","type":"regexp"},{"val":"/+/","type":"regexp"}],"name":"replace","type":"operator"}],"type":"prim","op":"+"}],"type":"qualified"},"args":[{"val":"$..results","type":"str"}],"name":"pick","type":"operator"},"var":["tweet"]}]},"start_line":79}],"meta_start_col":1,"meta":{"logging":"on","name":"Twitter Mashup Demo","meta_start_line":2,"author":"Michael Farmer","description":"","meta_start_col":1},"dispatch_start_line":13,"global_start_col":1,"ruleset_name":"a18x18"}
