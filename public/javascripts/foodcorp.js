$(document).ready(function() {
	
	// MAPS
	marker = [];
	markers = [];
	
	loc = [geoplugin_countryName(), geoplugin_region(), geoplugin_city()];
	
	a = ['meal[country]', 'meal[city]', 'meal[zip_code]', 'meal[street]', 'meal[street_number]'];
	
	// get default User inputs
	$('form.new_meal > :input').each(function() {
		var pos1 = a.indexOf( $(this).attr('name') );
		if (pos1 >= 0) {
			// wenn keine Daten vorhanden sind
			if($(this).val() != "") loc[pos1] = $(this).val();
		}
	});	
	
	// update Map when changing inputs
	$('form.new_meal > :input').blur(function() {
      var adress = "";
      if(jQuery.inArray($(this).attr('name'), a ) >=0) {
          var pos = a.indexOf( $(this).attr('name') );
          loc[pos] = $(this).val();
		  geocoder.getLocations(loc.join(', '), addToMap);
      }
    });

	function get_markers() {
		$('div.meal').each(function() {
			$(this).children('input').each(function() {
				if($(this).attr('title') == 'lat') lat = $(this).val();
				else lon = $(this).val()
			})
			markers.push({'latitude': lat, 'longitude' : lon });
		})
		
		return markers;
		
	}
	
	function addToMap(result) {
		console.log("other: LAT"+ result.Placemark[0].Point.coordinates[1] +" LON"+ result.Placemark[0].Point.coordinates[0]);
		
		if(!$.mobile) marker = [result.Placemark[0].Point.coordinates[1], result.Placemark[0].Point.coordinates[0]];
		$('#meal_lat').val(marker[0]);
		$('#meal_lon').val(marker[1]);
		
		/* TODO
			Add meals to map from start screen
		*/
		
		drawMap(loc);
	}
	
	// determine if the handset has client side geo location capabilities
	/* if (geo_position_js.init()) {
		geo_position_js.getCurrentPosition(geo_success, geo_error);
	}
	
	function geo_error() {
	 	console.log('geo.js not supported, switching to IP Localization');
	}
	
	function geo_success(p) {
		console.log('geo.js: LAT'+ p.coords.latitude + ' LON' + p.coords.longitude)
		marker = [p.coords.latitude, p.coords.longitude];
	} */
		
	function drawMap(env) {
		get_markers();
		console.log('using: LAT'+marker[0]+' LON'+marker[1]);
		$('#map').googleMaps({
			geocode: env.join(', '),
			markers: markers
		});
	}
	
	// Create new geocoding object
	geocoder = new GClientGeocoder();
	
	// Retrieve location information, pass it to addToMap()
	geocoder.getLocations(loc.join(), addToMap);
	
	// Calendar & Time for Meals
	$('.datepicker').datetime({
		userLang:'de',
		americanMode:false
	});
	
    // TAB HANDLING
    $(".tab_content").hide(); //Hide all content
    $("ul.tabs li:first").addClass("active").show(); //Activate first tab
    $(".tab_content:first").show(); //Show first tab content

    $("ul.tabs li").click(function() {

        $("ul.tabs li").removeClass("active"); //Remove any "active" class
        $(this).addClass("active"); //Add "active" class to selected tab
        $(".tab_content").hide(); //Hide all tab content

        var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
        $(activeTab).fadeIn(); //Fade in the active ID content
        return false;
    });

	// Validate inputs for new meal *FIX*
	$('form.new_meal').submit(function() {
		i = 0;
		$(this).children('input').each(function() {
			if($(this).val() == "") {
				alert($(this).attr('id') + ' is not valid!');
				i++;
			}
		})
		if(i>0) return false;
		else return true;
	});
		
    // DISABLE AVATAR UPLOAD IF FB AVATAR IS ENABLED
    if ($('#user_use_fb_avatar').is(':checked')) {
        $('#user_avatar').attr('disabled', true);
    }
    $("#user_use_fb_avatar").click(function() {
        if ($('#user_use_fb_avatar').is(':checked')) {
            $('#user_avatar').attr('disabled', true);
            $('#user_avatar').attr('value', '');
 		} else {
            $('#user_avatar').attr('disabled', false)
        }
    });

    // SETUP DATEPICKER
    $('.datepicker').datetime({
            userLang:'de',
            americanMode:false
    });
    
});
