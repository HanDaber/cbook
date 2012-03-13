$(document).ready(function(){
    var menu_items = $(".menu");
    var w = $(window).width();
    var n = menu_items.length;
        menu_items.width((w-120)/n);
    
    var filler_div = $("#filler");
    for(var i=50; i<100; i++){
        filler_div.append("<br /><div class=\"post r4\">&#"+i+";</div>");
    }
});