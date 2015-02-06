// jshint devel: true
'use strict';

Iris.Views['accounts-edit'] = Backbone.View.extend({

  events: {
    'change .system_selection': 'loadHospitals'
  },

  loadHospitals: function() {
    $('.default_hospital').load(
      '/dabo_admin/accounts/system_hospitals',
      {
        account: {
          'virtual_system_gid': $('.system_selection option:selected').val()
        }
      }
    );
  }
});
