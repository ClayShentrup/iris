// jshint nonew: false
'use strict';

Iris.Views['sessions-new'] = Backbone.View.extend({
  events: {
    'click .cancel_btn': '_clearLoginForm',
    'click #signup_link': '_clickSignupTab',
  },

  initialize: function() {
    new Iris.Views.passwordField({el: '.toggle_password'});
    $('#tabs').tabs();
  },

  _clearLoginForm: function() {
    this._input().val('').blur();
  },

  _input: function() {
    return this.$('input.form_control');
  },

  _clickSignupTab: function() {
    $('#tabs').tabs({active: 1});
  }
});
