// jshint devel: true
'use strict';

Iris.Views['accounts-new'] = Backbone.View.extend({

  events: {
    'change .system_selection': '_loadProviders'
  },

  _loadProviders: function() {
    Iris.Util.loadProviders().done(function() {
      $('.system_selection option:empty').remove();
    });
  }
});
