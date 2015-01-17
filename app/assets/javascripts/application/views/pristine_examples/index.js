// jshint devel: true
'use strict';

Iris.Views['pristine_examples-index'] = Backbone.View.extend({
  events: {
    'click #test': 'log'
  },

  initialize: function() {
    console.log('pristine_examples/index view initialized');
  },

  log: function() {
    console.log('Your click is recieved.');
    return false;
  }
});
