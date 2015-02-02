'use strict';

describe('ApplicationView', function() {
  var view;

  beforeEach(function() {
    view = new Iris.Views.application({el: '#body'});
  });

  describe('click #top_nav .hide_on_desktop .icon', function() {
    it('expands the search box on mobile', function() {
      console.log($('#body'))
      var body = view.render();
      expect($(body).find('#top_nav .nav_btns').length).toBe(2);
    });
  });
});
