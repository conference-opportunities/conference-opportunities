
describe('PassportCountrySelector', () => {
  var $select, $container;

  fixture.set('<div id="jasmine_content"></div>');

  beforeEach(() => {
    $select = $('<select id="country_code"><option value="BRA">Brazil</value><option value="POR">Portugal</value></select>').appendTo($('#jasmine_content'));
    $container = $('<div id="passport_container" class="passenger-information__passport">').appendTo($('#jasmine_content'));
  });

  describe('.create', () => {
    it('configures a new passport selector', () => {
      var selector = PassportCountrySelector.create("country_code", "passport_container", "prefix");
      expect(selector.select).toEqual($select[0]);
      expect(selector.container).toEqual($container[0]);
      expect(selector.prefixClass).toEqual("prefix");
    });
  });

  describe('#listen', () => {
    var selector;

    beforeEach(() => {
      selector = PassportCountrySelector.create("country_code", "passport_container", "passenger-information__passport");
    });

    it('responds to change events on the select box by setting classes on the container', () => {
      selector.listen();
      $('#country_code option[value="BRA"]').prop('selected', true);
      $select[0].dispatchEvent(new Event('change'));
      expect($container.attr('class')).toEqual('passenger-information__passport passenger-information__passport--BRA');
      $('#country_code option[value="POR"]').prop('selected', true);
      $select[0].dispatchEvent(new Event('change'));
      expect($container.attr('class')).toEqual('passenger-information__passport passenger-information__passport--POR');
    });
  });
});
