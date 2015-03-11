// jshint nonew: false
'use strict';

Iris.Views['registrations-edit'] = Backbone.View.extend({
  initialize: function() {
    $('.toggle_password').each(function(index, element) {
      new Iris.Views.passwordField({el: element});
    });
  }
});
