// jshint nonew: false
'use strict';

describe('ApplicationViewStickyScroll', function() {
  var view;
  var stickyElement;
  var stickyElementPos;
  var scrollTo;

  beforeEach(function() {
    loadFixture('news_items_controller');
    view = new Iris.Views['layouts/application'](
      {el: '#body', window: $('#body')}
    );

    $('#body').css({
      'overflow': 'scroll',
      'position': 'relative'}).height('500px');

    stickyElement = $('.sticky_element');

    stickyElementPos = function() {
      return stickyElement.position().top;
    };

    scrollTo = function(pos) {
      $('#body').scrollTop(pos).scroll();
    };
  });

  describe('sticky element', function() {
    it('starts below top nav', function() {
      expect(stickyElement).not.toHaveClass('is_sticky');
    });

    it('sticks to top of the view when window is scrolled down', function() {
      scrollTo(300);
      expect(stickyElementPos()).toBe(0);
    });

    it('does not stick unless its top is at top of the view', function() {
      scrollTo(20);
      expect(stickyElement).not.toHaveClass('is_sticky');
    });

    it('sticks to bottom of top nav when window is scrolled up', function() {
      spyOn(view, '_revealTopNav');
      scrollTo(300);
      scrollTo(200);
      expect(view._revealTopNav).toHaveBeenCalled();
      expect(stickyElement).toHaveClass('is_sticky');
    });
  });
});
