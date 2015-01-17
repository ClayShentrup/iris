// jshint nonew: false
'use strict';

var Iris = {
  Views: {}
};

$(document).on('ready page:load', function() {
  var viewName = $('body').data('viewName');
  var View = Iris.Views[viewName];
  if (View) {
    new View({
      el: 'body'
    });
  }
});
