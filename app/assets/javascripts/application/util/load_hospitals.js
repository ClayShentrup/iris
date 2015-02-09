'use strict';

Iris.Util.loadHospitals = function() {
  Iris.Util.getLoad(
    '.default_hospital',
    '/dabo_admin/accounts/new',
    {
      account: {
        'virtual_system_gid': $('.system_selection option:selected').val()
      }
    }
  );
};
