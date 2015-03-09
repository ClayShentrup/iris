'use strict';

Iris.Views.passwordField = Backbone.View.extend({
  events: {
    'click .toggle_password': '_togglePassword',
    'paste .paste_disabled': '_disablePaste'
  },

  _togglePassword: function(e) {
    var $button = $(e.currentTarget).toggleClass('active');
    var inputType = $button.hasClass('active') ? 'text' : 'password';

    $button.siblings('input').attr('type', inputType);
  },

  _disablePaste: function(e) {
    e.preventDefault();
  }
});
