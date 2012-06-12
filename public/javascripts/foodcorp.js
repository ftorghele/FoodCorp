$(document).ready(function() {

		fetchedData = false;
		calendarData = {};
		calendarHeight = 0;
		usersHomeLocation = '';
		
		getCalendar();
		
		$('#calendar').hoverIntent(function(){
			getCalendar();
			$('#calendar_container').animate({
				opacity: 1,
				height: 'toggle'
				
			}, 3000, function() {
				
			});
			
			}, function() {
			
			$('#calendar_container').fadeOut(300);
		});
		
		$('img.hoverMap').hover(function() {
			$('#map').stop().animate({'opacity': 1});
		}, function() {
			$('#map').stop().animate({'opacity': 0});
		});
		
		$('img.openMeal').click(function() {
			$('.display_meal').animate({'height': 0});
		}, function() {
			$('.display_meal').animate({'height': ''});
		});
			
		function getCalendar() {
			fetchedData = true;
			$.ajax({url:'/ajax/calendar', success:function(data) {
				$('#calendar_container').html(data);
			}});
			return calendarData;
		}


    // TOPNAV HANDLING
    current = document.location.pathname;
    if (current == "/meals/new") $('#topnav_cook').addClass('nav_active');
    else if (current == "/meals" || current == "/") $('#topnav_eat').addClass('nav_active');
    else if (current == "/users/sign_up") $('#topnav_register').addClass('nav_active');
    else if (current == "/about" || current == "/imprint" || current == "/terms") {};

	// notifications/FLash Messages
	$('p.notice').fadeOut(5000);
	$('p.alert').fadeOut(5000);
	
	// Sign Up Animation
	$('#signup_form_animate').click(function() {
            $('#login p').fadeOut(100);
            $('#signup_form').slideToggle(400);
            return false;
	});
		
	// MAPS
	depth = 15;
	marker = [];
	markers = [];
	loc = [];
	
	// true if user already entered home location
	if($("#current_user_locations").val() == "y"){
		// hier letzer stand location aus daten funktioniert noch nicht
		loc = [$('#meal_country').val(),
			   $('#meal_city').val(),
			   $('#meal_street').val()];
	}
	
	if( $('#current_user_location_street').val() && $('#current_user_location_activate').attr('checked') ){ 
		
		tmpgeocoder = new GClientGeocoder();
		var address = "";//"example: 821 Mohawk Street, Columbus OH";
		address += $('#current_user_location_street_number').val();
		address += ' ' + $('#current_user_location_street').val();
		address += ', ' + $('#current_user_location_city').val();
		usersHomeLocation = address;
		
		country = '';
		region = '';
		
		tmpgeocoder.getLocations(address, function(response){
			place = response.Placemark[0];
			
			country = place.AddressDetails.Country.CountryName
			region = place.AddressDetails.Country.AdministrativeArea.AdministrativeAreaName
			
			markers.push({'latitude': place.Point.coordinates[1],
						  'longitude': place.Point.coordinates[0],
						  'draggable': false,
						  icon: {
							    image: 'http://www.multimediatechnology.at/~fhs33078/Sem4/QPT2b_DinnerCollective/home.png', 
						  }
			});
			
			$('#currentLocation').html(region + ", "+ city);
		});
      
		//country = "Österreich"; // hier noch per current_user_location_zip_code country finden 
		//region = 'Steiermark';
		city = $('#current_user_location_city').val();
		street = $('#current_user_location_street').val();
		
		loc = [country, region, city];
		
		
	}
	
	if( $("#current_user_locations").val() == "y" || !$('#current_user_location_activate').attr('checked') ){
	    $('#currentLocation').html(geoplugin_region() + ", "+ geoplugin_city());
		loc = [geoplugin_countryName(), geoplugin_region(), geoplugin_city()];
	}
	
	a = ['meal[country]', 'meal[city]', 'meal[zip_code]', 'meal[street]', 'meal[street_number]'];
	
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

                return true;
	});
	
        //fraenk
        // get / set new position
	$('#searchSubmit').click(function() {
             geocoder.getLatLng(
                $('#searchLocation').val(),
                function(point) {
                  if (!point) {
                    //alert($('#searchLocation').val() + " not found");
                    $('#searchLon').val($.cookie("longitude"));
                    $('#searchLat').val($.cookie("latitude"));
                    $('#address').submit();
                  } else {
                    $('#searchLon').val(point.x);
                    $('#searchLat').val(point.y);
                    $('#address').submit();
                  }
                }
             );
	});
	
	// SLOW!
	// determine if the handset has client side geo location capabilities
        if (navigator.geolocation) {
			if(!$('#current_user_location_activate').attr('checked'))
				navigator.geolocation.getCurrentPosition(geo_success, geo_error);
			
			drawMap(loc);
        } else {
            drawMap(loc);
        }
	
	if (geo_position_js.init()) {
		geo_position_js.getCurrentPosition(geo_success, geo_error);
	}
	
	function geo_error() {
	 	drawMap(loc);
	}
	
	function geo_success(p) {
		geojsmarker = [{'latitude' : p.coords.latitude,
		 		   		'longitude' : p.coords.longitude,
				   		'draggable' : true,
						icon: { 
					                image: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png', 
					                shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
					                iconSize: '12, 20', 
					                shadowSize: '22, 20' 
					   }}];
		drawMap(loc);
		
		$.cookie("longitude", p.coords.longitude);
		$.cookie("latitude", p.coords.latitude);

                // fraenk
                $('#searchLat').val(p.coords.latitude);
                $('#searchLon').val(p.coords.longitude);
                $('#address').submit();
	}
	
	// Create new geocoding object
	geocoder = new GClientGeocoder();
	
	// Retrieve location information, pass it to addToMap()
	// when user has got home location and wished to show that at the beginning
	if($('#current_user_location_street').val() && $('#current_user_location_activate').attr('checked'))
		geocoder.getLocations(loc.join(), addHomeLocationToMap);
	else
		geocoder.getLocations(loc.join(), addToMap);
	
	// Calendar & Time for Meals
	$('.datepicker').datetime({
		userLang:'de',
		americanMode:false
	});

        // Calendar & Time for Meals
	$('.datepickeronly').datepicker({
		userLang:'de',
                dateFormat: 'yy-mm-dd',
		americanMode:false
	});
	
    // TAB HANDLING
    $(".tab_content").hide(); //Hide all content
    $("ul.tabs li:first a").addClass("nav_active").show(); //Activate first tab
    $(".tab_content:first").show(); //Show first tab content

    //On Click Event
    $("ul.tabs li").click(function() {

            $("ul.tabs li a").removeClass("nav_active", 500); //Remove any "active" class
            $(this).children().toggleClass("nav_active", 500); //Add "active" class to selected tab
            $(".tab_content").hide(); //Hide all tab content

            var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
            $(activeTab).fadeIn(500); //Fade in the active ID content
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

		if($('#searchLocation').length > 0) {
			if($('#searchLocation').val() != "") {
				geocoder.getLatLng(
            $('#searchLocation').val(),
            function(point) {
              if (!point) {
                //alert($('#searchLocation').val() + " not found");
                $('#searchLon').val($.cookie("longitude"));
                $('#searchLat').val($.cookie("latitude"));
                $('#address').submit();
              } else {
                $('#searchLon').val(point.x);
                $('#searchLat').val(point.y);
                $('#address').submit();
              }
            }
         );
			}
		}
    
	// animate Current User Location Form
	
	$('#animatecurrentUserLocationButton').toggle(
		function(){
			$('#currentUserLocation').animate({ height: '100px' });
			$('#currentUserLocation').fadeIn(500);
		},
		function(){
			$('#currentUserLocation').animate({ height: '0px' });
			$('#currentUserLocation').css('display','none');
		}
	);
	
});

function getAddress(latlng) {
	
    var lg = new GLatLng(latlng.lat(), latlng.lng());
    _tmpgeocoder = new GClientGeocoder();
    
    _tmpgeocoder.getLocations(lg, function(response){
			place = response.Placemark[0];
			console.log(place.AddressDetails);
			
			$("#meal_country").val(place.AddressDetails.Country.CountryName);
			
			if( place.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea != undefined && place.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea.Locality.DependentLocality != undefined ){
				$("#meal_city").val(place.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea.SubAdministrativeAreaName);
				$("#meal_zip_code").val(place.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea.Locality.DependentLocality.PostalCode.PostalCodeNumber);
				
				tmp_str = place.AddressDetails.Country.AdministrativeArea.SubAdministrativeArea.Locality.DependentLocality.Thoroughfare.ThoroughfareName;
				
				end = tmp_str.indexOf(" ");
				$("#meal_street_number").val(tmp_str.substr(0, end));
				$("#meal_street").val(tmp_str.substr(end, tmp_str.length-1));			
			}
	});
      
}

function panTo(lat, lon) {
	point = GLatLng.fromUrlValue(lat+', '+lon);
	//newLoc = $.googleMaps.gMap.fromLatLngToContainerPixel(new GLatLng(lat, lon));
	//$.googleMaps.gMap.panBy(new GSize( newLoc.x, newLoc.y ));
	//currentPoint = $.googleMaps.gMap.getCenter();
	$.googleMaps.gMap.setCenter(point);
}

function drawMap(env, rails, railsdepth) {
		get_markers();
		
		if(rails) { // Rails request - Update map
			railsenv = true;
			geocoder.getLocations(env.join(', '), addToMap);
			depth = railsdepth;
			return true;
		}
     
		mergeMarkers(marker, markers);
		
		$('#map').googleMaps({
				geocode: env.join(', '),
				markers: marker,
				depth: depth,
				controls: {
					mapType: [{
						remove: 'G_SATELLITE_MAP'
					}],
						type: {},
						zoom: {
							control: 'GSmallZoomControl'
						}
					}
		});
		
		position = $.googleMaps.marker[0];
		
		if($("#current_user_locations").val() == "y" && position && marker){
			//console.log(position);
			var _map = new GMap2(document.getElementById("map"));
			_map.addControl(new GSmallZoomControl());
			_map.addControl(new GMapTypeControl());
			var center = new GLatLng(marker[0].latitude, marker[0].longitude);
			_map.setCenter(center, 13);
			var _marker = new GMarker(center, {draggable: true});
			_map.addOverlay(_marker);
			GEvent.addListener(_marker, "dragend", getAddress);
		}
}

        // Grabs Locations for Meals, output them as Markers on the map
	function get_markers() {
		$('div.meal').each(function() {
			$(this).children('input').each(function() {
				if($(this).attr('title') == 'lat') lat = $(this).val();
				if($(this).attr('title') == 'lon') lon = $(this).val();

				// meal hidden, shown at markerclick
				//info = '#'+$(this).parent('div').attr('id');
			})
			markers.push({'latitude': lat,
						  'longitude': lon,
						  'draggable': false,
							icon: {
							      shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow',
							      shadowSize: '22, 20'
								},
						   'dragend' : 'getAddress'	
						});
		})
		
		if($('.display_meal').length > 0) {
			loc = $('.country').text()+" "+$('.zip').text()+" "+$('.city').text()+" "+$('.street').text()+" "+$('.street_number').text();
			loc = loc.split(" ");
		}

		return markers;

	}
	
	function mergeMarkers(marker1, marker2) {
		$.merge(marker1, marker2);
	}

	function addToMap(result) {
		
		if(typeof(result) != 'undefined') 
		marker = [{'latitude': result.Placemark[0].Point.coordinates[1], 
							'longitude': result.Placemark[0].Point.coordinates[0],
							'draggable': true,
							icon: { 
										 image: 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png', 
										 shadow: 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow', 
										 iconSize: '12, 20', 
										 shadowSize: '22, 20' 
							}
		}];

		else if($('#currentLocation').val() != "" && $('#meal_lon').val() !="" && $('#meals_distance_stream').length == 0) {
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
		
		if(typeof railsenv != 'undefined') drawMap(env);
		else drawMap(loc);
	
	}
	
	function addHomeLocationToMap(response){
		  place = response.Placemark[0];

		  point = new GLatLng(place.Point.coordinates[1],
							  place.Point.coordinates[0]);
			
		  $('#map').googleMaps({
				geocode: usersHomeLocation,
				markers: markers,
				depth: depth,
				controls: {
					mapType: [{
						remove: 'G_SATELLITE_MAP'
					}],
						type: {},
						zoom: {
							control: 'GSmallZoomControl'
						}
					}
				});
			
	}
	
