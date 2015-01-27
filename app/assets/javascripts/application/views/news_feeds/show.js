// jshint devel: true
'use strict';

Iris.Views['news_feeds-show'] = Backbone.View.extend({
  initialize: function() {
    if ($('#news_feed_filter .unselected').is(':hidden')) {

      $('#news_feed_filter').on('click', function() {
        $('.unselected').slideToggle(100);
      });
    }
  }
});
