// jshint devel: true
'use strict';

Iris.Views['sessions-new'] = Backbone.View.extend({
  events: {
    'click .cancel_btn': '_clearLoginForm'
  },

  _clearLoginForm: function() {
    this._input().val('').blur();
  },

  _input: function() {
    return this.$('input.form_control');
  }
});
