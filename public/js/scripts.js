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
	
    // http://webdesign.maratz.com/lab/fancy-checkboxes-and-radio-buttons/jquery.html:
    // function setupLabel() {
    //             if ($('.label_check input').length) {
    //                 $('.label_check').each(function(){ 
    //                     $(this).removeClass('c_on');
    //                 });
    //                 $('.label_check input:checked').each(function(){ 
    //                     $(this).parent('label').addClass('c_on');
    //                 });                
    //             };
    //             if ($('.label_radio input').length) {
    //                 $('.label_radio').each(function(){ 
    //                     $(this).removeClass('r_on');
    //                 });
    //                 $('.label_radio input:checked').each(function(){ 
    //                     $(this).parent('label').addClass('r_on');
    //                 });
    //             };
    //         };
    //      $('body').addClass('has-js');
    //         $('.label_check, .label_radio').click(function(){
    //             setupLabel();
    //         });
    //         setupLabel();
        
        
	// Select which container to load pjax responses into
    // $("a.pjax").pjax("#main-container");
    // $(".posts").pjax("#middle");
});