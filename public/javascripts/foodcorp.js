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

	function get_markers() {
		$('div.meal').each(function() {
			$(this).children('input').each(function() {
				if($(this).attr('title') == 'lat') lat = $(this).val();
				else lon = $(this).val();
				info = '#'+$(this).parent('div').attr('id');
			})
			markers.push({'latitude': lat, 
						  'longitude': lon,
						  'draggable': false, 
							info: { layer: info } });
		})
		
		return markers;
		
	}
	
	function addToMap(result) {
		console.log("other: LAT"+ result.Placemark[0].Point.coordinates[1] +" LON"+ result.Placemark[0].Point.coordinates[0]);
		
		if(!$.mobile) marker = [{'latitude': result.Placemark[0].Point.coordinates[1], 
								 'longitude': result.Placemark[0].Point.coordinates[0],
								'draggable': true}];
								
		$('#meal_lat').val(result.Placemark[0].Point.coordinates[1]);
		$('#meal_lon').val(result.Placemark[0].Point.coordinates[0]);
			
		drawMap(loc);
	}
		
	function drawMap(env) {
		get_markers();
		(markers.length > 1)? marker = markers : marker = marker;
		$('#map').googleMaps({
			geocode: env.join(', '),
			markers: marker
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
	
	// SLOW!
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
    
});
