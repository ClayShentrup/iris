// jshint nonew: false
'use strict';

describe('ApplicationView', function() {
  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-generate-a-' +
      'fixture-with-conversations'
    );
    new Iris.Views['layouts/application']({el: '#body', window: $('#body')});
  });

  describe('clicking on the close icon', function() {
    it('closes the flash message feedback bar', function() {
      $('#body').append(
        '<div class="feedback_bar" class="line_height_buffer_base.' +
        'vertical_padding_small">' +
        '<span class="icon_close icon"></span>' +
        '</div>'
      );
      expect($('.feedback_bar:visible').length).toBe(1);
      $('.feedback_bar .icon_close').click();
      expect($('.feedback_bar:visible').length).toBe(0);
    });
  });
});
