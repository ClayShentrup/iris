// jshint nonew: false
'use strict';

var Iris = {
  Views: {},
  Util: {}
};

$(document).on('ready page:load', function() {
  new Iris.Views.application({el: '#body'});

  var viewName = $('body').data('viewName');
  var View = Iris.Views[viewName];

  if (View) {
    new View({
      el: 'body'
    });
  }
});
