'use strict';

Iris.Views.passwordField = Backbone.View.extend({
  events: {
    'click .icon': '_togglePassword',
    'keyup input': '_toggleIcon',
    'change input': '_toggleIcon',
    'paste input': '_disablePaste'
  },

  initialize: function() {
    this._toggleIcon();
  },

  _togglePassword: function() {
    this._button().toggleClass('active');
    var inputType = this._button().hasClass('active') ? 'text' : 'password';

    this._passwordInput().attr('type', inputType);
  },

  _toggleIcon: function() {
    if (this._passwordInput().val().length > 0) {
      this._button().show();
    } else {
      this._button().hide();
    }
  },

  _disablePaste: function(e) {
    e.preventDefault();
  },

  _button: function() {
    return this.$('.icon');
  },

  _passwordInput: function() {
    return this.$('input');
  },
});
