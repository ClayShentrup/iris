// jshint devel: true
'use strict';

Iris.Views['accounts-edit'] = Backbone.View.extend({

  events: {
    'change .system_selection': 'loadHospitals'
  },

  loadHospitals: function() {
    Iris.Util.getLoad(
      '.default_hospital',
      '/dabo_admin/accounts/new',
      {
        account: {
          'virtual_system_gid': $('.system_selection option:selected').val()
        }
      }
    );
  }
});
