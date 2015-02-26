// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var jQueryAutocompleteDelay = 300;
  var resultsDropdown;
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
    resultsDropdown = $('.dropdown_items.hospital');
  });

  describe('typing into the search input', function() {
    beforeEach(function() {
      expect(resultsDropdown).toBeHidden();
      $('.dropdown_button.hospital').click();
      expect(resultsDropdown).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(resultsDropdown).toContainText('UCSF Mission Bay');
      expect(resultsDropdown).toContainText('UCSF Parnassus');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(resultsDropdown.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'UCSF%20Mission', oneHospitalFixture);
      searchAutocomplete(searchInput, 'UCSF Mission');
      expect(resultsDropdown.find('li')).toHaveLength(1);
      expect(resultsDropdown).toContainText('UCSF Mission Bay');
      expect(resultsDropdown).not.toContainText('UCSF Parnassus');
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
      expect(resultsDropdown.find('ul')).toBeEmpty();
    });
  });
});
