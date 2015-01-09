'use strict';

Dabo = {
  Views: {}
};

$(document).on('ready page:load', function(){
  var viewName = $('body').data('viewName');
  var View = Dabo.Views[viewName];
  if (View) {
    new View({
      el: 'body'
    });
  }
});
