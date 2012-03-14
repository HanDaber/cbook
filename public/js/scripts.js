$(document).ready( function() {
    var menu_items = $(".menu");
    var w = $(window).width();
    var n = menu_items.length;
	var x = 0.2;
	menu_items.width((w-(x*w))/n);
	$(window).resize( function() {
		var w = $(window).width();
		if( w < 600 ) { w = 600; }
		menu_items.width((w-(x*w))/n);	
	});
        
    var filler_div = $("#filler");
    for(var i=50; i<100; i++){
        filler_div.append("<br /><div class=\"post r4\">&#"+i+";</div>");
    }
    $("a.pjax").pjax("#main-container");
});