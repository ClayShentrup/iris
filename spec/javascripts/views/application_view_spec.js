'use strict';

describe('ApplicationView', function() {

  beforeEach(function() {
    loadFixtures('news_items_controller-get-index-default.html');
    var view = new Iris.Views.application({el: '#body'});
  });

  describe('click #top_nav .hide_on_desktop .icon', function() {
    it('expands the search box on mobile', function() {
      expect($('#top_nav .nav_btns:visible').length).toBe(2);
      $('#top_nav .hide_on_tablet_portrait.hide_on_desktop .icon_search')
        .click();
      expect($('#top_nav .nav_btns:visible').length).toBe(0);
    });

    it('click changes icon from search to close on mobile', function() {
      // TODO: check focus, see appplication_view.js
      var icon  = $('#top_nav .search.hide_on_desktop .icon');
      var input = $('#top_nav .search.hide_on_desktop input');
      expect(icon).toHaveClass('icon_search');
      expect(icon).not.toHaveClass('icon_close');
      icon.click();
      expect(icon).not.toHaveClass('icon_search');
      expect(icon).toHaveClass('icon_close');
    });

    it('click changes icon from search to close on desktop', function() {
      var icon  = $('#top_nav .search.hide_on_mobile .icon');
      var input = $('#top_nav .search.hide_on_mobile input');
      expect(icon).toHaveClass('icon_search');
      expect(icon).not.toHaveClass('icon_close');
      icon.click();
      expect(icon).not.toHaveClass('icon_search');
      expect(icon).toHaveClass('icon_close');
    });
  });
});
