// jshint nonew: false
'use strict';

describe('ApplicationView', function() {

  beforeEach(function() {
    loadFixture('news_items_controller-get-index-default');
    var view = new Iris.Views.application({el: '#body'});
  });

  describe('clicking on the search icon', function() {
    it('expands the search box on mobile', function() {
      expect($('#top_nav .nav_btns:visible').length).toBe(2);
      $('#top_nav .hide_on_tablet_portrait.hide_on_desktop .icon_search')
        .click();
      expect($('#top_nav .nav_btns:visible').length).toBe(0);
    });

    it('click changes icon from search to close on mobile', function() {
      // TODO: check focus, see appplication_view.js
      var iconSearch = $('#top_nav .search.hide_on_desktop .icon_search');
      var iconClose = $('#top_nav .search.hide_on_desktop .icon_close');
      var input = $('#top_nav .search.hide_on_desktop input');
      expect(iconSearch).not.toHaveClass('hidden');
      expect(iconClose).toHaveClass('hidden');
      iconSearch.click();
      expect(iconSearch).toHaveClass('hidden');
      expect(iconClose).not.toHaveClass('hidden');
    });

    it('click changes icon from search to close on desktop', function() {
      var iconSearch = $('#top_nav .search.hide_on_mobile .icon_search');
      var iconClose = $('#top_nav .search.hide_on_mobile .icon_close');
      var input = $('#top_nav .search.hide_on_mobile input');
      expect(iconSearch).not.toHaveClass('hidden');
      expect(iconClose).toHaveClass('hidden');
      iconSearch.click();
      expect(iconSearch).toHaveClass('hidden');
      expect(iconClose).not.toHaveClass('hidden');
    });
  });
  describe('clicking on the close icon', function() {
    it('closes the flash message feedback bar', function() {
      // TODO: Remove append() when fixtures have flash message
      $('#body').append(
        '<div id="feedback_bar" class="line_height_buffer_base.' +
        'vertical_padding_small">' +
        '<span class="icon_close icon"></span>' +
        '</div>'
      );
      expect($('#feedback_bar:visible').length).toBe(1);
      $('#feedback_bar .icon_close').click();
      expect($('#feedback_bar:visible').length).toBe(0);
    });
  });
});
