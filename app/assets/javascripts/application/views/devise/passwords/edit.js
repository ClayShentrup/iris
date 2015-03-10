// jshint nonew: false
'use strict';

Iris.Views['passwords-edit'] = Backbone.View.extend({
  initialize: function() {
    new Iris.Views.passwordField({el: '#body'});
  }
});
