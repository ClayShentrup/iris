// jshint devel: true
'use strict';

Iris.Views['news_items-index'] = Backbone.View.extend({
  initialize: function() {
    if ($('#news_feed_filter .dropdown').is(':hidden')) {
      $('#news_feed_filter').on('click', function() {
        $('.dropdown').slideToggle(100);
      });
    }
    $('#news_feed_filter .hide_on_desktop').on('click', function() {
      $('#news_feed_filter .icon.icon_large.icon_float_right')
        .toggleClass('icon_arrow_large_down icon_arrow_large_up');
    });
  }
});
