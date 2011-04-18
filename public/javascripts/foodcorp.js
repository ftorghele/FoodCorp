$(document).ready(function() {
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
    
});




var map;
var geocoder = null;
var addressMarker;
var markerPoint;


jQuery(document).ready(function () {		
	$('.submit').click(function() {
		var form = $(this).parent().attr('id');
		$('#'+form + ' > :input').each(function() {
			if ($(this).val() == "") {
				alert($(this).attr('name') + " not valid!")
				return false;
			}
		})
	});
});


jQuery(document).ready(function () {
	
	$('.datepicker').datepicker({
		altFormat: 'yyyy-mm-dd'
	});
	
});

function load() {
  if (!navigator.geolocation) {
    alert("GeoLocation API not available!");
  }
  
  if (GBrowserIsCompatible()) {
    map = new GMap2(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    map.setCenter(new GLatLng(22.917922, -16.875), 2);
    map.setMapType(G_HYBRID_MAP);

    geocoder = new GClientGeocoder();
  }
}

function success(position) {
	var latitude = position.coords.latitude;
  	var longitude = position.coords.longitude;
	markerPoint = new GLatLng(latitude, longitude);
	alert(markerPoint);
}
 
function error(msg) {
	console.log(typeof msg == 'string' ? msg : "error");
}

function showAddress(address, countryCode) {

if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(success, error);
} else {
	alert("your current position is not available");
}

  if (geocoder) {
    geocoder.setBaseCountryCode(countryCode);
	
    geocoder.getLatLng(address, function(point) {
        if (!point) {
          alert(address + " not found");
        } else {
          if (addressMarker) {
		 
            map.removeOverlay(addressMarker);
          }
		  
		  var extractLatLan = /\(([-.\d]*), ([-.\d]*)/.exec( point );
			if (extractLatLan) {
				var lat = parseFloat(extractLatLan[1]);
				var lon = parseFloat(extractLatLan[2]);
			}
			
			$("input#lat").val(lat);
			$("input#lon").val(lon);
			
          addressMarker = new GMarker(markerPoint);
          map.setCenter(markerPoint);
		  map.setZoom(17);
          map.addOverlay(addressMarker);
        }
      }
    );
  }
}
