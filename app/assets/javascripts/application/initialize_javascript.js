Dabo = {
  Views: {}
};

$(document).on('ready page:load', function(){
  var viewName = $('body').data('viewName');
  var view = Dabo.Views[viewName];
  if (view) {
    new view({
      el: 'body'
    });
  }
});
