// jshint devel: true
'use strict';

Iris.Views['news_feeds-show'] = Backbone.View.extend({
  initialize: function() {
    $('#news_feed_filter').menu({
      position: { my: "left top", at: "left bottom" }
    });
  },
});
