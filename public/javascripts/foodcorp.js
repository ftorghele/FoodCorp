$(document).ready(function() {
	
	// Sign Up Animation
	$('.signup_form_animate').click(function() {
		if($('.signup_form_animate').html() == "Login") {
			$('#fb_sign_in').hide(100);
			$('.signup_form').slideToggle(400);
			$('.signup_form_animate').html('Register');
			return false;
		}
		else {
			return true;
		}
	});
	
		
	// MAPS
	marker = [];
	markers = [];
	loc = [geoplugin_countryName(), geoplugin_region(), geoplugin_city()];
	a = ['meal[country]', 'meal[city]', 'meal[zip_code]', 'meal[street]', 'meal[street_number]'];
	
	// Home Page currentLocation div
	$('#currentLocation').html(geoplugin_region() + ", "+ geoplugin_city());
	
	//if location is determined, set cookie for geo.js
	($.cookie("longitude") && $.cookie("latitude"))? geo_set = true : geo_set = false;
	
	// get default User inputs
	$('form.new_meal > :input, form.edit_meal > :input').each(function() {
		var pos1 = a.indexOf( $(this).attr('name') );
		if (pos1 >= 0) {
			// wenn keine Daten vorhanden sind
			if($(this).val() != "") loc[pos1] = $(this).val();
		}
		
		
	});	
	
	// update Map when changing inputs
	$('form.new_meal > :input, form.edit_meal > :input').blur(function() {
      if(jQuery.inArray($(this).attr('name'), a ) >=0) {
          var pos = a.indexOf( $(this).attr('name') );
          loc[pos] = $(this).val();
		  geocoder.getLocations(loc.join(', '), addToMap);
      }
    });

	// Validate inputs for new meal
	$('form.new_meal, form.edit_meal').submit(function() {
		
		position = $.googleMaps.marker[0];
		
		$('#meal_lat').val(position.getPoint().lat());
		$('#meal_lon').val(position.getPoint().lng());
		
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
	

	// Grabs Locations for Meals, output them as Markers on the map
	function get_markers() {
		$('div.meal').each(function() {
			$(this).children('input').each(function() {
				if($(this).attr('title') == 'lat') lat = $(this).val();
				else lon = $(this).val();
				
				// meal hidden, shown at markerclick
				//info = '#'+$(this).parent('div').attr('id');
			})
			markers.push({'latitude': lat, 
						  'longitude': lon,
						  'draggable': false,
							icon: {  
							      shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
							      shadowSize: '22, 20' 
								} 
						});
		})
		
		return markers;
		
	}
	
	function addToMap(result) {
		//console.log("other: LAT"+ result.Placemark[0].Point.coordinates[1] +" LON"+ result.Placemark[0].Point.coordinates[0]);		
		
		// SET LOCAL POSITION MARKER (BLUE)
		//console.log(result.Placemark);
		
		if(typeof(result.Placemark) != 'undefined') marker = [{'latitude': result.Placemark[0].Point.coordinates[1], 
								 'longitude': result.Placemark[0].Point.coordinates[0],
								'draggable': true,
								icon: { 
								                image: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png', 
								                shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
								                iconSize: '12, 20', 
								                shadowSize: '22, 20' 
								            }
								}];
								
		if($('#currentLocation').val() != "" && $('#meal_lon').val() !="" && $('#meals_distance_stream').length == 0) {
			marker = [{'latitude': $('input#meal_lat').val(), 
									 'longitude': $('input#meal_lon').val(),
									'draggable': true,
									icon: { 
									                image: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png', 
									                shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
									                iconSize: '12, 20', 
									                shadowSize: '22, 20' 
									            }
									}];
		}
		
		(geo_set)? $('#meal_lat').val($.cookie('latitude')) : $('#meal_lat').val(result.Placemark[0].Point.coordinates[1]);
		(geo_set)? $('#meal_lat').val($.cookie('latitude')) : $('#meal_lat').val(result.Placemark[0].Point.coordinates[1]);
		
		drawMap(loc);
	}
	
	
	// SLOW!
	// determine if the handset has client side geo location capabilities
	if(geo_set) {
		if (navigator.geolocation) {
	  		navigator.geolocation.getCurrentPosition(geo_success, geo_error);

	  		drawMap();
		} else {
	  		drawMap(loc);
			} 
	}
	
	if (geo_position_js.init()) {
		geo_position_js.getCurrentPosition(geo_success, geo_error);
	}
	
	function geo_error() {
	 	drawMap(loc);
	}
	
	function geo_success(p) {
		console.log('geo.js: LAT'+ p.coords.latitude + ' LON' + p.coords.longitude)
		geojsmarker = [{'latitude' : p.coords.latitude,
		 		   		'longitude' : p.coords.longitude,
				   		'draggable' : true,
						icon: { 
					                image: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png', 
					                shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
					                iconSize: '12, 20', 
					                shadowSize: '22, 20' 
					   }}];
		drawMap();
		
		$.cookie("longitude", p.coords.longitude);
		$.cookie("latitude", p.coords.latitude);
	}
		
	function drawMap(env) {
		get_markers();
		
		if(markers.length >= 1) $.merge(marker, markers); // merge current position marker with meal list markers
		
		if(env && !window.geojsmarker)
		$('#map').googleMaps({
				geocode: env.join(', '),
				markers: marker,
				controls: {
				            mapType: [{ 
							                remove: 'G_SATELLITE_MAP' 
							            }, { 
							                remove: 'G_NORMAL_MAP' 
							            }],
							type: {},
										zoom: {
											control: 'GSmallZoomControl'
								}
				        }
		});
		
		if (window.geojsmarker && geojsmarker[0].latitude) {
			$('#map').googleMaps({
			    	latitude: geojsmarker[0].latitude,
			        longitude: geojsmarker[0].longitude,
					markers: geojsmarker,
					controls: {
					            mapType: [{ 
								                remove: 'G_SATELLITE_MAP' 
								            }, { 
								                remove: 'G_NORMAL_MAP' 
								            }],
								type: {},
											zoom: {
												control: 'GSmallZoomControl'
									}
					        }
			    });
		}
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
    $('.tab_content').hide();
    if(location.hash != '') {
        var target = location.hash.split('#')[1]
        $(location.hash).show();
        $('ul.tabs li:has(a[rel='+target+'])').addClass('active').show(); // NOT WORING
    } else {
        $("ul.tabs li:first").addClass("active").show();
	$(".tab_content:first").show();
    }

    //On Click Event
    $('ul.tabs li').click(function() {
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

function panTo(lat, lon) {
	point = GLatLng.fromUrlValue(lat+', '+lon);
	//newLoc = $.googleMaps.gMap.fromLatLngToContainerPixel(new GLatLng(lat, lon));
	//$.googleMaps.gMap.panBy(new GSize( newLoc.x, newLoc.y ));
	//currentPoint = $.googleMaps.gMap.getCenter();
	$.googleMaps.gMap.setCenter(point);
}