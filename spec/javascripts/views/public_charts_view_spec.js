// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var jQueryAutocompleteDelay = 300;
  var hospitalDropdown;
  var searchInput;
  var searchEndpoint = '/hospital_search_results/?term=';
  var oneHospitalFixture =
    'hospital_search_results_controller-index-return-one-hospital.html';
  var twoHospitalsFixture =
    'hospital_search_results_controller-index-return-two-hospitals.html';

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-public-data'
    );
    new Iris.Views['public_charts-show']({el: '#body'});

    searchInput = $('.dropdown_items.hospital .search_box input');
    hospitalDropdown = $('.dropdown_items.hospital');
  });

  describe('typing into the search input', function() {
    beforeEach(function() {
      expect(hospitalDropdown).toBeHidden();
      $('.dropdown_button.hospital').click();
      expect(hospitalDropdown).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(hospitalDropdown).toContainText('UCSF Mission Bay');
      expect(hospitalDropdown).toContainText('UCSF Parnassus');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(hospitalDropdown.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'UCSF%20Mission', oneHospitalFixture);
      searchAutocomplete(searchInput, 'UCSF Mission');
      expect(hospitalDropdown.find('li')).toHaveLength(1);
      expect(hospitalDropdown).toContainText('UCSF Mission Bay');
      expect(hospitalDropdown).not.toContainText('UCSF Parnassus');
    });
  });

  describe('selecting a hospital', function() {
    var compareEndpoint = '/hospital_search_results/';
    var compareFixture =
      'hospital_search_results_controller-show-hospital-to-compare.html';

    it('refreshes the compare dropdown', function() {
      var hospitalCityAndState;
      var hospitalState;
      var hospitalSystem;
      var hospitalNation;

      stubAjaxRequest(searchEndpoint + 'UCSF', oneHospitalFixture);
      searchAutocomplete(searchInput, 'UCSF');

      var hospitalToSelect = $('#body li:contains(UCSF)').data();
      var hospitalId = hospitalToSelect.hospitalId;

      stubAjaxRequest(compareEndpoint + hospitalId, compareFixture);
      hospitalDropdown.find('li').click();
      jasmine.clock().tick();

      hospitalCityAndState = $('.dropdown_items.compare ul li:first');
      hospitalState = $('.dropdown_items.compare ul li:nth-child(2)');
      hospitalSystem = $('.dropdown_items.compare ul li:nth-child(3)');
      hospitalNation = $('.dropdown_items.compare ul li:last');

      expect(hospitalCityAndState).toContainText('San Francisco');
      expect(hospitalCityAndState).toContainText('2 Hospitals');
      expect(hospitalState).toContainText('CA');
      expect(hospitalState).toContainText('3 Hospitals');
      expect(hospitalSystem).toContainText('Test System');
      expect(hospitalSystem).toContainText('2 Hospitals');
      expect(hospitalNation).toContainText('Nation-wide');
      expect(hospitalNation).toContainText('4 Hospitals');
    });
  });

  describe('close button', function() {
    it ('clears the field and the previous search results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);
      searchAutocomplete(searchInput, 'UCSF');
      $('.dropdown_button.hospital').click();

      $('.search_box .icon_close').click();

      expect($('.dropdown_items')).toBeHidden();
      $('.dropdown_button.hospital').click();

      expect(searchInput).toBeEmpty();
      expect(hospitalDropdown.find('ul')).toBeEmpty();
    });
  });
});
