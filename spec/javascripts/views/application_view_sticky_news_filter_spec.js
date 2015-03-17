// jshint nonew: false
'use strict';

describe('ApplicationViewStickyNewsFilter', function() {
  var newsFilter;
  var newsFilterVisible;
  var newsFilterPos;
  var scrollTo;
  var view;
  var newsItemsView;

  beforeEach(function() {
    loadFixture('news_items_controller');
    newsFilter = $('.stick');

    $('#body').css('position', 'relative');

    view = new Iris.Views['layouts/application'](
      {el: '#body', window: $('#body')}
    );

    newsItemsView = new Iris.Views['news_items-index'](
      {el: '#body', window: $('#body')}
    );

    $('#body').css('overflow', 'scroll').height('500px');

    newsFilterPos = function() {
      return newsFilter.position().top;
    };

    scrollTo = function(pos) {
      $('#body').scrollTop(pos).trigger('scroll');
    };

    scrollTo(0);
  });

  describe('news filter sticky behavior', function() {
    it('starts below top nav', function() {
      expect(newsFilterPos()).toBe(44);
    });

    it('sticks to the top of the view when scrolled down', function() {
      scrollTo(300);
      expect(newsFilterPos()).toBe(0);
    });

    it('unsticks from the view when scrolled up to the top', function() {
      scrollTo(20);
      expect(newsFilterPos()).toBe(44 - 20);
    });

    it('scrolls up with the page', function() {
      scrollTo(300);
      scrollTo(285);
      expect(newsFilterPos()).toBe(-newsFilter.height() + 15);
    });
  });
});
