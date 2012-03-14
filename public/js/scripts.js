$(document).ready( function() {
    var menu_items = $(".menu");
    var footer = $("footer");
    var w = $(window).width();
    var n = menu_items.length;
	var x = 0.2;
	menu_items.width((w-(x*w))/n);
	$(window).resize( function() {
		var this_w = $(window).width();
		if( this_w < 600 ) { 
		    this_w = 600; 
		    footer.css('background-color', '#556688'); 
		} else if ( this_w > 900 ) {
		    this_w = 900;
		    footer.css('background-color', '#003377');
		} else {
		    footer.css('background-color', '#003377');
		}
		
		menu_items.width((this_w-(x*this_w))/n);
	});
        
    var filler_div = $("#filler");
    for(var i=50; i<100; i++){
        filler_div.append("<br /><div class=\"post r4\">&#"+i+";</div>");
    }
    $("a.pjax").pjax("#main-container");
});