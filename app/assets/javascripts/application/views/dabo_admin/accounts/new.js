// jshint devel: true
'use strict';

Iris.Views['accounts-new'] = Backbone.View.extend({
  initialize: function() {
    $('.system_selection').change(function() {
      $('.default_hospital').load(
        '/dabo_admin/accounts/system_hospitals',
        {
          account: {
            'virtual_system_gid': $('.system_selection option:selected').val()
          }
        }
      );
    });
  }
});
