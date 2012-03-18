$(document).ready( function() {

    // Resize footer menu items
    var menu_items = $(".menu");
    var footer = $("footer");
    var w = $(window).width();
    var n = menu_items.length;
	var x = 0.2;

	menu_items.width( (w - (x * w))/n );

	$(window).resize( function() {
		var this_w = $(window).width();
		menu_items.width( (this_w - (x * this_w))/n );
	});
	
	// Select which container to load pjax responses into
    // $("a.pjax").pjax("#main-container");
    // $(".posts").pjax("#middle");
});