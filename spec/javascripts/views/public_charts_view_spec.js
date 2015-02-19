// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-saves-fixture-public-data'
    );
    new Iris.Views['public_charts-show']({el: '#body'});
  });

  describe('typing into the search input', function() {
    var jQueryAutocompleteDelay = 300;
    var resultsDropdown;
    var searchInput;
    var searchEndpoint = '/hospital_search_results/?term=';
    var oneHospitalFixture =
      'hospital_search_results_controller-index-' +
      'return-one-hospital-one_hopsital.html';
    var twoHospitalsFixture =
      'hospital_search_results_controller-index-' +
      'return-two-hospitals-two_hopsitals.html';

    beforeEach(function() {
      resultsDropdown = $('.dropdown_items.hospital');
      searchInput = $('.dropdown_items.hospital .search_box input');

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
});
