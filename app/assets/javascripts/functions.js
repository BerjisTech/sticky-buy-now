var loadScript = function(url, callback){

  /* JavaScript that will load the jQuery library on Google's CDN.
     We recommend this code: http://snipplr.com/view/18756/loadscript/.
     Once the jQuery library is loaded, the function passed as argument,
     callback, will be executed. */
	 
    var script = document.createElement("script")
    script.type = "text/javascript";
 
    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }
 
    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);	 

};

var myAppJavaScript = function($){
  /* Your app's JavaScript here.
     $ in this scope references the jQuery object we'll use.
     Don't use 'jQuery', or 'jQuery191', here. Use the dollar sign
     that was passed as argument.*/
     
  $(function() {

    if($("#shop_use_custom_styles").prop("checked")){
      $("#custom-styles").show();
    }else{
      $("#custom-styles").hide();      
    }    
    
    $("#shop_use_custom_styles").on("change",function(){
      $("#custom-styles").toggle();     
    });    
    
    $(".advanced-settings").hide();

    if($("#shop_desktop_reveal_at").val() != 0 && $("#shop_desktop_reveal_at").val() != "addtocart"){
      $(".reveal-at-desktop").show();
    }else{
      $(".reveal-at-desktop").hide();      
    }
    
    $("#shop_desktop_reveal_at").on("change",function(){
      if($("#shop_desktop_reveal_at").val() != 0 && $("#shop_desktop_reveal_at").val() != "addtocart"){
        $(".reveal-at-desktop").show();
      }else{
        $(".reveal-at-desktop").hide();
      }
    });
    
    $("#desktop-reveal-bar-at-custom").on("change",function(){
      $("#shop_desktop_reveal_at option:last-child").val($("#desktop-reveal-bar-at-custom").val());    
    });

    if($("#shop_mobile_reveal_at").val() != 0 && $("#shop_mobile_reveal_at").val() != "addtocart"){
      $(".reveal-at-mobile").show();
    }else{
      $(".reveal-at-mobile").hide();      
    }
    
    $("#shop_mobile_reveal_at").on("change",function(){
      if($("#shop_mobile_reveal_at").val() != 0 && $("#shop_mobile_reveal_at").val() != "addtocart"){
        $(".reveal-at-mobile").show();
      }else{
        $(".reveal-at-mobile").hide();
      }
    });
    
    $("#mobile-reveal-bar-at-custom").on("change",function(){
      $("#shop_mobile_reveal_at option:last-child").val($("#mobile-reveal-bar-at-custom").val());    
    });
    
    $("#support-form").hide();
    
    $("#show-help-btn").click(function(e){
      $("#support-form").toggle();
      e.preventDefault();
    });
        
    
    
    $("#toggle-style-settings").on("click",function(){
      $("#style-settings").toggle();
      if($("#toggle-style-settings span").text() == "+"){
        $("#toggle-style-settings span").text("-");
      }else{
        $("#toggle-style-settings span").text("+");
      }
    });        
      
    $("#toggle-general-advanced").on("click",function(){
      $("#general-advanced").toggle();
      if($("#toggle-general-advanced span").text() == "+"){
        $("#toggle-general-advanced span").text("-");
      }else{
        $("#toggle-general-advanced span").text("+");
      }      
    });    
    
    $("#toggle-mobile-advanced").on("click",function(){
      $("#mobile-advanced").toggle();
      if($("#toggle-mobile-advanced span").text() == "+"){
        $("#toggle-mobile-advanced span").text("-");
      }else{
        $("#toggle-mobile-advanced span").text("+");
      }      
    });    
    
    $("#toggle-desktop-advanced").on("click",function(){
      $("#desktop-advanced").toggle();
      if($("#toggle-desktop-advanced span").text() == "+"){
        $("#toggle-desktop-advanced span").text("-");
      }else{
        $("#toggle-desktop-advanced span").text("+");
      }      
    });        
    
  });
  

  
};

if ((typeof jQuery === 'undefined') || (parseFloat(jQuery.fn.jquery) < 1.7)) {
  loadScript('//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js', function(){
    jQuery321 = jQuery.noConflict(true);
    myAppJavaScript(jQuery321);
  });
} else {
  myAppJavaScript(jQuery);
}