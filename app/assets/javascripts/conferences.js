window.ConferenceDetailsEdit = function() {
  var locationInput = document.getElementById('conference_detail_location');
  new google.maps.places.Autocomplete(locationInput);
};
