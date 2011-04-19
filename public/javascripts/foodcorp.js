$(document).ready(function() {
	
	a = ['meal[country]', 'meal[city]', 'meal[zip_code]', 'meal[street]', 'meal[street_number]'];
    b = [];
	
	// MAPS
	
	loc = [];

	$('input').each(function() {
		var pos1 = a.indexOf( $(this).attr('name') );
		console.log(pos1);
		if (pos1 >= 0) {
			loc[pos1] = $(this).val();
		}
	})
	
	
	$('#map').googleMaps({
		geocode: loc.join()
	});
	
	// Calendar & Time for Meals
	$('.datepicker').datetime({
		userLang:'de',
		americanMode:false,
	});
	
    // TAB HANDLING
    $(".tab_content").hide(); //Hide all content
    $("ul.tabs li:first").addClass("active").show(); //Activate first tab
    $(".tab_content:first").show(); //Show first tab content

    //On Click Event
    $("ul.tabs li").click(function() {

        $("ul.tabs li").removeClass("active"); //Remove any "active" class
        $(this).addClass("active"); //Add "active" class to selected tab
        $(".tab_content").hide(); //Hide all tab content

        var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
        $(activeTab).fadeIn(); //Fade in the active ID content
        return false;
    });

	$('.submit').click(function() {
		var form = $(this).parent().attr('id');
		$('#'+form + ' > :input').each(function() {
			if ($(this).val() == "") {
				alert('bla');
				return false;
			}
		})

	});
    
	$('form.new_meal > :input').blur(function() {

          var adress = "";
          if(jQuery.inArray($(this).attr('name'), a ) >=0) {
              var pos = a.indexOf( $(this).attr('name') );
              b[pos] = $(this).val();
              console.log(b);
              showCoordinates(b.join(" "));
          }

    })
    
});
