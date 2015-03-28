// jshint nonew: false
'use strict';

describe('ApplicationViewStickyElements', function() {
  var stickyElements;
  var stickyElementPos;
  var scrollTo;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-generate-a-' +
      'fixture-with-conversations'
    );
    new Iris.Views['layouts/application']({el: '#body', window: $('#body')});

    $('#body').css({
      'overflow': 'scroll',
      'position': 'relative'}).height('500px');

    stickyElements = $('.is_sticky');

    stickyElementPos = function() {
      return stickyElements.first().position().top;
    };

    scrollTo = function(pos) {
      $('#body').scrollTop(pos).scroll();
    };
  });

  describe('sticky element', function() {
    it('sticks to top of the view when window is scrolled down', function() {
      scrollTo(300);
      expect(stickyElementPos()).toBe(0);
    });
  });
});
