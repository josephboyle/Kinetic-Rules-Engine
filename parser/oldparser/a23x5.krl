{"global":[{"content":"#gilow a:link {    color:#ffffff;    text-decoration:none;    }    #gilow a:visited {    color:#ffffff;    text-decoration:none;    }    #gilow a:hover {    color:#ffffff;    text-decoration:none;    }    #gilow a:active {    color:#ffffff;    text-decoration:none;    }    #gilow a:linked {    color:#ffffff;    text-decoration:none;    }            #KOBJ_anno_list {        \tleft: 120px;    \tposition: relative;        }        ","type":"css"}],"global_start_line":18,"dispatch":[{"domain":"homeloans.va.gov","ruleset_id":null},{"domain":"www.valoans.com","ruleset_id":null},{"domain":"www.vamortgagecenter.com","ruleset_id":null},{"domain":"www.va.gov","ruleset_id":null},{"domain":"www.military.com","ruleset_id":null},{"domain":"www.directvaloans.com","ruleset_id":null},{"domain":"www.google.com","ruleset_id":null},{"domain":"www.bing.com","ruleset_id":null},{"domain":"www.yahoo.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"float_html","args":[{"val":"absolute","type":"str"},{"val":"top:0px","type":"str"},{"val":"right:50px","type":"str"},{"val":"kynetx_html_code_info","type":"var"}],"modifiers":[{"value":{"val":0,"type":"num"},"name":"delay"},{"value":{"val":"false","type":"bool"},"name":"draggable"},{"value":{"val":"false","type":"bool"},"name":"scrollable"},{"value":{"val":"appear","type":"str"},"name":"effect"}],"vars":null},"label":"info"},{"action":{"source":null,"name":"float_html","args":[{"val":"absolute","type":"str"},{"val":"top:0px","type":"str"},{"val":"right:0px","type":"str"},{"val":"lf","type":"var"}],"modifiers":null,"vars":null},"label":"lf"}],"post":null,"pre":[{"rhs":"<div class=\"lowvarates-notification\" id=\"gilow\">    \t<div class=\"lowvarates-notification default\" style=\"padding:15px; -moz-border-radius-topleft:5px; -moz-border-radius-topright:5px; -moz-border-radius-bottomright:5px; -moz-border-radius-bottomleft:5px; background-color:#181818; color:rgb(255, 255, 255); font-family:Helvetica,Arial,sans-serif; font-size:11px; margin-bottom:5px; margin-top:5px; min-height:35px; opacity:1; text-align:left; width:243px;\">            <div class=\"message\">            <div id=\"kobj_discount\" style=\"-moz-border-radius-topleft:5px; -moz-border-radius-topright:5px; -moz-border-radius-bottomright:5px; -moz-border-radius-bottomleft:5px; background-color: #121535; width: 230px; text-align:center;\">                            <div style=\"color:rgb(0, 0, 0);\"><a href=\"http://www.lowvarates.com\" style=\"color:#121535\"><img src=\"http://www.frameaction.com/lowvarates/images/overlaycontent.jpg\" border=\"0\" /></a></div>                          </div>  <div align=\"right\" id=\"gilow\"><a onclick=\"KOBJ.BlindUp('#gilow');false\">close window</a></div>  \t</div>  </div>  \n ","lhs":"kynetx_html_code_info","type":"here_doc"}],"name":"popbox","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"homeloans.va.gov|www.valoans.com|www.vamortgagecenter.com|www.va.gov|www.military.com|www.directvaloans.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":21},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"va_low_annotate","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"val":[{"rhs":{"val":"http://www.frameaction.com/lowvarates/images/logoAnnotation.jpg","type":"str"},"lhs":"www.homeloans.va.gov"},{"rhs":{"val":"http://www.frameaction.com/lowvarates/images/logoAnnotation.jpg","type":"str"},"lhs":"www.valoans.com"},{"rhs":{"val":"http://www.frameaction.com/lowvarates/images/logoAnnotation.jpg","type":"str"},"lhs":"www.vamortgagecenter.com"},{"rhs":{"val":"http://www.frameaction.com/lowvarates/images/logoAnnotation.jpg","type":"str"},"lhs":"www.directvaloans.com"}],"type":"hashraw"},"lhs":"sites","type":"expr"}],"name":"annotate","start_col":5,"emit":"var host_url = \"\";  \tvar host_appended = false;    \tfunction va_low_annotate(obj){  \t\t  \t\tvar entryURL = $K(obj).find(\"span.url, cite\").text();  \t\tvar host = KOBJ.get_host(entryURL);  \t\tif(sites[host] && host_url != host ){  \t\t\tmsg = '<a href=\"http://www.lowvarates.com\"><img src=\"'+sites[host][\"val\"]+'\" alt=\"Low VA\" border=\"0\"/></a>';  \t\t\thost_url = host;  \t\t\thost_appended = true;  \t\t\treturn msg;  \t\t} else {  \t\t\thost_url = host;  \t\t\thost_appended = false;  \t\t\treturn false;  \t\t}  \t}              ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"google.com|bing.com|yahoo.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":41},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"percolate","start_col":5,"emit":"var url_prefix = \"http://frag.kobj.net/clients/hav_percolate/images/\";    search_percolate = {};  search_percolate.defaults = {    \"name\": \"KOBJ\",    \"sep\": \"<div></div>\",    \"text_color\":\"#CCC\",    \"height\":\"100px\",    \"left_margin\": \"0px\",    \"left_padding\": \"5px\",    \"right_padding\" : \"15px\",    \"font_size\":\"12px\",    \"font_family\": \"Verdana, Geneva, sans-serif\",    \"resultElement\": \"li.g, li div.res\"  };    function percolate_search_results(selector){        function mk_list_item(i) {      return $K(i).attr(        {\"class\": \"KOBJ_item\"        }).css(          {\"margin-bottom\":\"5px\"    \t});    }    function mk_rm_div (anchor) {      var logo_item = mk_list_item(anchor);      var title = $K(\"<h2>\").text(\"Locals Care Links\").css(        {\"margin\": \"3px\",         \"color\": \"#676767\",         \"font-size\":\"small\",         \"font-family\":\"arial,sans-serif\"          });      var top_box = $K('<ol>').css(        {\"display\": \"block\",         \"padding-top\": \"18px\"         }).attr(\"id\", search_percolate.defaults.name+\"_top_box\").append(logo_item);      var inner_div = $K('<div>').css(        {        }).append(top_box);      if (search_percolate.defaults.tail_background_image){        inner_div.css({             \"background-image\": \"url(\" + search_percolate.defaults.tail_background_image + \")\",             \"background-repeat\": \"no-repeat\",             \"background-position\": \"right top\"  \t\t    });      }      var rm_div = $K('<div>').attr({\"class\":\"cxx\"}).css(        {\"border\":\"none\",         \"padding-bottom\": \"3px\",         \"padding-left\": \"5px\",         \"padding-right\": \"5px\",         \"max-width\": \"48em\",         \"min-height\": \"100px\"        }).append(inner_div);      if (search_percolate.defaults.head_background_image){       rm_div.css({             \"background-image\": \"url(\" + search_percolate.defaults.head_background_image +\")\",             \"background-repeat\": \"no-repeat\",             \"background-position\": \"left top\"  \t\t});      }      return rm_div;    }        function move_item (obj) {      if($K('#'+search_percolate.defaults.name+'_top_box').find(\"li\").is('.'+search_percolate.defaults.name+'_item')) {        $K('#'+search_percolate.defaults.name+'_top_box').append(search_percolate.defaults.sep).append(mk_list_item(obj));      } else {        if($K('#mbEnd').size() !== 0) {          $K(\"#mbEnd\").after(mk_rm_div(obj));        } else {          $K(\"#ssb\").after(mk_rm_div(obj));        }      }    }    \tfunction serpslurp(){  \t\t\t\tvar cloc = document.location.toString();  \t\t  \t\tvar m;  \t\tvar start = 0;  \t\ttry { m = cloc.match(/(start)=(\\d+)/);  \t\t\tstart = parseInt(m[2]);  \t\t    } catch(err) {}  \t\tvar next = (start+10).toString();  \t\tif(m) {  \t\t    cloc = cloc.replace(/start=\\d+/, \"start=\" + next);  \t\t} else {  \t\t    cloc = cloc + \"&start=\" + next;  \t\t}  \t\tcloc += \"&num=90\";  \t\treturn cloc;  \t}    \t\t$K(search_percolate.defaults.resultElement).each(function() {  \t\tif (selector(this)) {  \t\t\tmove_item(this);  \t\t}  \t});    \t\t$K.get(serpslurp(), function(res) {  \t\t$K(search_percolate.defaults.resultElement, res).each(function() {  \t\t\tif (selector(this)) {  \t\t\t\tmove_item(this);  \t\t\t}  \t\t});  \t});    }      percolate_data = {'www.lowvarates.com':true};    function percolate_selector(obj){  \t\tvar entryURL = $K(obj).find(\"span.url, cite\").text();  \t\tvar host = KOBJ.get_host(entryURL);  \t\tvar isTrue = percolate_data[host];  \t\tif(isTrue)  \t\t\treturn true;  \t\telse  \t\t\treturn false;  }    percolate_search_results(percolate_selector);            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.google.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":51}],"meta_start_col":5,"meta":{"logging":"off","name":"Low VA Rates","meta_start_line":2,"author":"Danny DeBate","meta_start_col":5},"dispatch_start_line":7,"global_start_col":5,"ruleset_name":"a23x5"}
