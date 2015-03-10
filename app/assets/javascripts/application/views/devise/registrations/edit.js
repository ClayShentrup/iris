// jshint nonew: false
'use strict';

Iris.Views['registrations-edit'] = Backbone.View.extend({
  initialize: function() {
    new Iris.Views.passwordField({el: '#body'});
  }
});
