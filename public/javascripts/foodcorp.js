var map;
var geocoder = null;
var addressMarker;

function load() {
  if (GBrowserIsCompatible()) {
    map = new GMap2(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    map.setCenter(new GLatLng(22.917922, -16.875), 2);
    map.setMapType(G_HYBRID_MAP);

    geocoder = new GClientGeocoder();
  }
}

function showAddress(address, countryCode) {

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
			
          addressMarker = new GMarker(point);
          map.setCenter(point);
		  map.setZoom(17);
          map.addOverlay(addressMarker);
        }
      }
    );
  }
}
