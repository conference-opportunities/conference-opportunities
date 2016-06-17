window.ConferenceDetailsEdit = function() {
  var locationInput = document.getElementById('conference_detail_location');
  var autocomplete = new google.maps.places.Autocomplete(locationInput);
  autocomplete.addListener('place_changed', getCoords(locationInput.value));
};

// On location Autocomplete select
function getCoords(location) {
  var url = 'http://nominatim.openstreetmap.org/search/' + location + '?format=json&addressdetails=1';
  $.ajax({ 
  	url: url 
  }).done(function(data) {
    var lat = data[0]["lat"].toString();
    var lon = data[0]["lon"].toString();
    var center = lon + ',' + lat;
    console.log(center);
  }).fail(function() {
  	console.log('uh oh');
  });
}