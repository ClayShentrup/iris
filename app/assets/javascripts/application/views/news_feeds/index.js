// jshint devel: true
'use strict';

Iris.Views['news_items-index'] = Backbone.View.extend({

  defaults: {
    window: $(window)
  },

  initialize: function(options) {
    this.options = _.extend({}, this.defaults, options);

    if ($('#news_feed_filter .dropdown').is(':hidden')) {
      $('#news_feed_filter').on('click', function() {
        $('.dropdown').slideToggle(100);
      });
    }
    $('#news_feed_filter .hide_on_desktop').on('click', function() {
      $('#news_feed_filter .icon.icon_large.float_right')
        .toggleClass('icon_arrow_large_down icon_arrow_large_up');
    });
  },
});
