// jshint devel: true
'use strict';

Iris.Views['accounts-new'] = Backbone.View.extend({

  events: {
    'change .system_selection': '_loadHospitals'
  },

  _loadHospitals: function() {
    Iris.Util.loadHospitals().done(function() {
      $('.system_selection option:empty').remove();
    });
  }
});
