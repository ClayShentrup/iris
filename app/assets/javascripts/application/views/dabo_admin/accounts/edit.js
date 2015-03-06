// jshint devel: true
'use strict';

Iris.Views['accounts-edit'] = Backbone.View.extend({

  events: {
    'change .system_selection': Iris.Util.loadProviders
  }
});
