// This file is only used for the application, not for jasmine tests
//
// jshint nonew: false
'use strict';

Iris.initializeViews = function() {
  new Iris.Views['layouts/application']({el: '#body'});

  var viewName = $('body').data('viewName');
  var View = Iris.Views[viewName];

  if (View) {
    new View({
      el: '#body'
    });
  }
};
