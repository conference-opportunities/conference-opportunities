window.ConferenceDetailsEdit = function() {
  var locationInput = document.getElementById('conference_location');
  new google.maps.places.Autocomplete(locationInput);
};
