// jshint nonew: false
'use strict';

Iris.Views['sessions-new'] = Backbone.View.extend({
  initialize: function() {
    new Iris.Views.passwordField({el: '#body'});
  }
});
