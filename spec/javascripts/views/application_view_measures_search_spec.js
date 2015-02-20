// jshint nonew: false
'use strict';

describe('ApplicationViewMeasuresSearch', function() {

  var measuresFixturePath = 'measures_search_results_controller.html';
  var searchEndpoint = '/measures_search_results/?term=';
  var search;
  var searchInput;
  var searchResults;
  var mainContent;

  beforeEach(function() {
    loadFixture('news_items_controller');
    mainContent = $('.main_content');
    new Iris.Views.application({el: '#body'});
  });

  describe('for desktop', function() {
    beforeEach(function() {
      search = $('.search.hide_on_mobile');
      searchResults = search.find('ul.results');
      searchInput = search.find('input');
    });

    it('returns results for a search and hides main content', function() {
      stubAjaxRequest(searchEndpoint + 'heart', measuresFixturePath);
      searchAutocomplete(searchInput, 'heart');
      expect(searchResults).toContainElement(
        $('ul.measures li.left_buffer_small')
      );
      expect($('.main_content')).toHaveCss({opacity: '0'});
    });
  });
});
