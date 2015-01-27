// jshint devel: true
'use strict';

Iris.Views['news_feeds-show'] = Backbone.View.extend({
  initialize: function() {
    if ($('#news_feed_filter .unselected').is(':hidden')) {
      $('#news_feed_filter').on('click', function() {
        $('.unselected').slideToggle(100);
      });
    }
    $('#news_feed_filter').on('click', function() {
      $('#news_feed_filter .icon.icon_large.icon_right')
        .toggleClass('icon_arrow_large_down icon_arrow_large_up');
    });
  }
});
