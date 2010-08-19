{"global":[{"source":"http://www.gitbuzz.com/channel/GetChannel/1013","name":"TheSEO","type":"dataset","datatype":"JSON","cachable":{"period":"seconds","value":"5"}}],"global_start_line":22,"dispatch":[{"domain":"google.com","ruleset_id":null},{"domain":"bing.com","ruleset_id":null},{"domain":"yahoo.com","ruleset_id":null},{"domain":"facebook.com","ruleset_id":null}],"dispatch_start_col":3,"meta_start_line":2,"rules":[{"cond":{"args":[{"val":"SearchTerms","type":"var"},{"val":"KeywordRegex","type":"var"}],"type":"ineq","op":"like"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"annotate_selector","type":"var"}],"modifiers":null,"vars":null},"label":null},{"action":{"source":null,"name":"percolate","args":[{"val":"percolate_selector","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.SEO.AdWords","type":"str"}],"name":"pick","type":"operator"},"lhs":"keywords","type":"expr"},{"rhs":{"args":[{"val":"/","type":"str"},{"args":[{"val":"keywords","type":"var"},{"val":"/gi","type":"str"}],"type":"prim","op":"+"}],"type":"prim","op":"+"},"lhs":"KeywordRegex","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.SEO.Title","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyTitle","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.SEO.ImageURL","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyImage","type":"expr"},{"rhs":"<img src=\"#{MyImage}\" title=\"#{MyTitle}\">\n        ","lhs":"MySEOTemplate","type":"here_doc"}],"name":"seo_helper","start_col":3,"emit":"// Hack to reference the JSON data in the global section\n        TheSEO = KOBJ['data']['TheSEO'];\n                \n        // JavaScript function to determine if we should percolate this domain\n        // First get the domain of the search result item begin evaluated\n        // Return true if the domain of the search result item is within our set\n        function percolate_selector(obj) {\n          var domain = $K(obj).data(\"domain\");\n          return (domain in TheSEO.SEO.DomainNames);\n        }\n        \n        function annotate_selector(obj) {\n          var domain = $K(obj).data(\"domain\");\n          if (domain in TheSEO.SEO.DomainNames) {\n            return MySEOTemplate;\n          }\n          else {\n            return false;\n          }\n        }\n      ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"[google|bing|yahoo].*(?:&q|\\?q)=([^&]*)","legacy":1,"type":"prim_event","vars":["SearchTerms"],"op":"pageview"},"foreach":[]},"start_line":28},{"cond":{"args":[{"args":[{"val":"AdCentsActive","type":"var"},{"val":"active","type":"str"}],"type":"ineq","op":"eq"},{"args":[{"val":"SearchTerms","type":"var"},{"val":"KeywordRegex","type":"var"}],"type":"ineq","op":"like"}],"type":"pred","op":"&&"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"td.std>ol.nobr","type":"str"},{"val":"MyAdCentsTemplate","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.SEO.AdWords","type":"str"}],"name":"pick","type":"operator"},"lhs":"keywords","type":"expr"},{"rhs":{"args":[{"val":"/","type":"str"},{"args":[{"val":"keywords","type":"var"},{"val":"/gi","type":"str"}],"type":"prim","op":"+"}],"type":"prim","op":"+"},"lhs":"KeywordRegex","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.GoogleAd.googleadStatus","type":"str"}],"name":"pick","type":"operator"},"lhs":"AdCentsActive","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.GoogleAd.googleadTitle","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyTitle","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.GoogleAd.googleadBody","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyBody","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.GoogleAd.googleadCite","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyCite","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.GoogleAd.googleadURL","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyURL","type":"expr"},{"rhs":"<li>\n            <h3><a href=\"#{MyURL}\" id=\"an1\">#{MyTitle}</a></h3>\n            #{MyBody}\n            <cite>#{MyCite}</cite>\n          </li>\n        ","lhs":"MyAdCentsTemplate","type":"here_doc"}],"name":"google_addcents","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"[google|bing|yahoo].*(?:&q|\\?q)=([^&]*)","legacy":1,"type":"prim_event","vars":["SearchTerms"],"op":"pageview"},"foreach":[]},"start_line":77},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookHome.facebookhomeStatus","type":"str"}],"name":"pick","type":"operator"},"lhs":"HomeSponsorActive","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookHome.facebookhomeTitle","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyTitle","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookHome.facebookhomeBody","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyBody","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookHome.facebookhomeImage","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyImage","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookHome.facebookhomeURL","type":"str"}],"name":"pick","type":"operator"},"lhs":"MyURL","type":"expr"},{"rhs":"<div id=\"FaceCentsHomePageAd\" class=\"emu_sponsor mbm\">\n            <div class=\"UIEmuHPFrame emu_ad\">\n              <div class=\"UIEMUHPFrame_creative\">\n                <div class=\"UIEMUHPFrame_titleAndFeedback\">\n                  <a rel=\"async-post\" title=\"Report this ad\" class=\"UIEmuFrame_x hide\" href=\"\">X</a>\n                  <a href=\"#{MyURL}\" class=\"ad_title UIEMUFrame_forceLTR\">#{MyTitle}</a>\n                </div>\n                <div class=\"UIImageBlock clearfix\">\n                  <a target=\"\" href=\"#{MyURL}\" class=\"ad_image UIImageBlock_Image UIImageBlock_SMALL_Image\"><img src=\"#{MyImage}\" class=\"img\"></a>\n                  <div class=\"UIImageBlock_Content UIImageBlock_SMALL_Content\">\n                    <div>\n                      <a target=\"\" href=\"#{MyURL}\" class=\"ad_text UIEMUFrame_forceLTR\">#{MyBody}</a>\n                    </div>\n                  </div>\n                </div>\n              </div>\n            </div>\n          </div>\n        ","lhs":"HomeSponsorTemplate","type":"here_doc"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookAd.facebookadStatus","type":"str"}],"name":"pick","type":"operator"},"lhs":"FaceSponsorActive","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookAd.facebookadTitle","type":"str"}],"name":"pick","type":"operator"},"lhs":"FaceTitle","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookAd.facebookadBody","type":"str"}],"name":"pick","type":"operator"},"lhs":"FaceBody","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookAd.facebookadImage","type":"str"}],"name":"pick","type":"operator"},"lhs":"FaceImage","type":"expr"},{"rhs":{"obj":{"val":"TheSEO","type":"var"},"args":[{"val":"$.FacebookAd.facebookadURL","type":"str"}],"name":"pick","type":"operator"},"lhs":"FaceURL","type":"expr"},{"rhs":"<div id=\"FaceCentsSponsorAd\" class=\"fbEmu fbEmuVertical fbEmuLegacy\">\n            <div class=\"fbEmuHide\">\n              <a href=\"\" rel=\"async-post\" title=\"Report this ad\" class=\"fbEmuLink thex emuEventfad_hide\"><span class=\"fbEmuLinkText\">&nbsp;</span></a>\n            </div>\n            <div class=\"hover\">\n              <div class=\"title\">\n                <a href=\"#{FaceURL}\" target=\"_blank\" class=\"fbEmuLink forceLTR emuEvent1\"><span class=\"fbEmuLinkText\">#{FaceTitle}</span></a>\n              </div>\n              <div class=\"image\">\n                <a href=\"#{FaceURL}\" target=\"_blank\" class=\"fbEmuLink emuEvent1\"><img src=\"#{FaceImage}\" class=\"img\"></a>\n              </div>\n              <div class=\"body\">\n                <a href=\"#{FaceURL}\" target=\"_blank\" class=\"fbEmuLink forceLTR emuEvent1\"><span class=\"fbEmuLinkText\">#{FaceBody}</span></a>\n              </div>\n            </div>\n          </div>\n        ","lhs":"FaceSponsorTemplate","type":"here_doc"}],"name":"facebook_addcents","start_col":3,"emit":"// Facebook updates content with AJAX, so we have to watch the DOM\n      // in order to determine if changes have been made to the page\n      \n      // Register callback function when content changes\n      // http://devex.kynetx.com/questions/212/inconsistent-facebook-rule-firing\n      KOBJ.watchDOM(\"#content\", PrependSponsoredAd);\n      KOBJ.watchDOM(\"#menubar_container\", PrependSponsoredAd);\n      KOBJ.watchDOM(\"#pagefooter\", PrependSponsoredAd);\n      KOBJ.watchDOM(\"#pagelet_presence\", PrependSponsoredAd);\n      \n      // Insert our Ads into the page if there are not there already\n      function PrependSponsoredAd() {\n        if (HomeSponsorActive == \"active\") {\n          // Have we already inserted our ad on the homepage?\n          if ( $K(\"#FaceCentsHomePageAd\").length == 0) {\n            $K(\"#home_sponsor_nile\").prepend(HomeSponsorTemplate);\n          }\n        }\n        if (FaceSponsorActive == \"active\") {\n          // Have we already inserted our Sponsor ad?\n          if ( $K(\"#FaceCentsSponsorAd\").length == 0) {\n            $K(\"div#ssponsor\").prepend(FaceSponsorTemplate);\n          }\n        }\n      }\n      \n      // Fire the function once to initially place the Ads\n      PrependSponsoredAd();\n    ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.facebook.com/.*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":106}],"meta_start_col":3,"meta":{"keys":{"errorstack":"49828eb94a62c864b1e02f1fe0460af6"},"logging":"on","name":"GitBuzz_1013","meta_start_line":2,"author":"Ed Orcutt <edo@aculis.com>","description":"Combine search engine SEO augmentation, Google AdSense Augmentation\n      and Facebook ad Augmentation. Wish me luck!\n    ","meta_start_col":3},"dispatch_start_line":15,"global_start_col":3,"ruleset_name":"a733x2"}
