// jshint nonew: false
'use strict';

describe('ApplicationViewMeasuresSearch', function() {
  var measuresFixturePath = 'measure_search_results_controller.html';
  var searchEndpoint = '/measure_search_results?term=';
  var search;
  var searchInput;
  var searchResults;
  var innerContent;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-generate-a-' +
      'fixture-with-conversations'
    );
    innerContent = $('.inner_content');
    new Iris.Views['layouts/application']({el: '#body', window: $('#body')});
  });

  describe('for desktop', function() {
    beforeEach(function() {
      search = $('.search');
      searchResults = search.find('ul.results');
      searchInput = search.find('input');
    });

    it('returns results for a search and hides main content', function() {
      stubAjaxRequest(searchEndpoint + 'patient', measuresFixturePath);
      searchAutocomplete(searchInput, 'patient');
      expect(searchResults).toContainElement(
        $('li.line_height_base.link')
      );
      expect(innerContent).toHaveCss({opacity: '0'});
    });
  });
});
