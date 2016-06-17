window.ConferenceDetailsEdit = function() {
  var locationInput = document.getElementById('conference_detail_location');
  var autocomplete = new google.maps.places.Autocomplete(locationInput);
  autocomplete.addListener('place_changed', getCoords(locationInput.value));
};

// on select
function getCoords(location) {
  // console.log('hey hey');
  // console.log(location);
  // console.log('in getCoords');
  var url = 'http://nominatim.openstreetmap.org/search/' + location + '?format=json&addressdetails=1';
  $.ajax({ 
  	url: url 
  }).done(function(json) {
  	console.log(json);
  });
}