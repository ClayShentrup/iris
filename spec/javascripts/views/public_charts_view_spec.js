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

    it('displays a list of matching results', function() {
      var searchTerm = 'UCSF';
      var resultsDropdown = $('.dropdown_items.hospital');
      var searchInput = $('.dropdown_items.hospital .search_box input');
      var searchResults = $('.dropdown_items.hospital ul');

      expect(resultsDropdown).toBeHidden();
      $('.dropdown_button.hospital').click();
      expect(resultsDropdown).toBeVisible();

      stubAjaxRequest(
        '/hospital_search_results/?term=' + searchTerm,
        'hospital_search_results_controller-index-get-index-default'
      );

      searchAutocomplete(searchInput, searchTerm);
      expect(resultsDropdown).toContainText('UCSF Mission Bay');
      expect(resultsDropdown).toContainText('UCSF Parnassus');
    });
  });
});
