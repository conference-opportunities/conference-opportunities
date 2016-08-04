Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.set_default_stub([{
  'latitude'     => 37.783333,
  'longitude'    => -122.416667,
  'address'      => 'San Francisco, CA, USA',
  'state'        => 'San Francisco',
  'state_code'   => 'CA',
  'country'      => 'United States',
  'country_code' => 'US'
}])
