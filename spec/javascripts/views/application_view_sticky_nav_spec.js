// jshint nonew: false
'use strict';

describe('ApplicationViewStickyTopNav', function() {
  var topNav;
  var topNavVisible;
  var topNavPos;
  var scrollTo;
  var view;

  beforeEach(function() {
    loadFixture('news_items_controller');
    topNav = $('#top_nav');

    view = new Iris.Views['layouts/application'](
      {el: '#body', window: $('#body')}
    );

    $('#body').css('overflow', 'scroll').height('100px');

    topNavPos = function() {
      return topNav.position().top;
    };

    topNavVisible = function() {
      return topNavPos() >= 0;
    };

    scrollTo = function(pos) {
      $('#body').scrollTop(pos).trigger('scroll');
    };

    scrollTo(0);
  });

  describe('topnav menu sticky behavior', function() {
    it('is not visible when scrolling past it\'s height', function() {
      scrollTo(300);
      expect(topNavVisible()).toBe(false);
    });

    it('becomes visible again when scrolling back up', function() {
      scrollTo(300);
      scrollTo(200);
      expect(topNavVisible()).toBe(true);
    });

    it('scrolls down with the page', function() {
      scrollTo(20);
      expect(topNavPos()).toBe(-20);
    });

    it('scrolls up with the page', function() {
      scrollTo(300);
      scrollTo(285);
      expect(topNavPos()).toBe(-topNav.height() + 15);
    });
  });
});
