// jshint nonew: false
'use strict';

Iris.Views['password_expired-show'] = Backbone.View.extend({
  initialize: function() {
    $('.toggle_password').each(function(index, element) {
      new Iris.Views.passwordField({el: element});
    });
  }
});
