// jshint nonew: false
'use strict';

Iris.Views['users-new'] = Backbone.View.extend({
  initialize: function() {
    new Iris.Views.passwordField({el: '.toggle_password'});
  }
});
