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
	
	
/*	
	var xref = {
        carrots: "<b>Carrots</b> are delicious and may turn your skin orange!",
        asparagus: "<b>Asparagus</b> is one of the first vegetables of the spring. " 
            +"Being a dark green, it's great for you, and has interesting side effects.",
        squash: "<b>Squash</b> is a winter vegetable, and not eaten raw too much. Is that really squash?",
        redpepper: "<b>Red peppers</b> are actually the same as green peppers, they've just been left on "
            +"the vine longer. Delicious when fire-roasted.",
        yellowpepper: "Similar to red peppers, <b>yellow peppers</b> are sometimes sweeter.",
        celery: "<b>Celery</b> is a fascinating vegetable. Being mostly water, it actually takes your body "
            +"more calories to process it than it provides.",
        cucumbers: "<b>Cucumbers</b> are cool.",
        broccoli: "<b>Broccoli</b> is like a forest of goodness in your mouth. And very good for you. "
            +"Eat lots of broccoli!",
        dip: "Everything here is good for you but this one. <b>Don't be a dip!</b>"
    };
	
    var image = $('#img_map');
    image.mapster({
        fillOpacity: 0.4,
        fillColor: "d42e16",
        stroke: true,
        strokeColor: "3320FF",
        strokeOpacity: 0.8,
        strokeWidth: 4,
        singleSelect: true,
        mapKey: 'name',
        listKey: 'name',
        onClick: function (e) {
            var newToolTip = "defaultDipTooltip";

            // update text depending on area selected
            $('#selections').html(xref[e.key]);

            // if Asparagus selected, change the tooltip
            if (e.key === 'asparagus') {
                newToolTip = "OK. I know I have come down on the dip before, but let's be real. "
                    +"Raw asparagus without any of that delicious ranch and onion dressing "
                    +"slathered all over it is not so good.";
            }
            image.mapster('set_options', { 
                areas: [{
                    key: "dip",
                    toolTip: newToolTip
                    }]
                });
        },
        showToolTip: true,
        toolTipClose: ["tooltip-click", "area-click"],
        areas: [
            {
                key: "redpepper",
                fillColor: "ffffff"
            },
            {
                key: "yellowpepper",
                fillColor: "000000"
            },
            {
                key: "carrots",
                fillColor: "000000"
            },
            {
                key: "dip",
                toolTip: defaultDipTooltip
            },
            {
                key: "asparagus",
                strokeColor: "FFFFFF"
            }
            ]
    });​
        
        */
	// Select which container to load pjax responses into
    // $("a.pjax").pjax("#main-container");
    // $(".posts").pjax("#middle");
});