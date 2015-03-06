'use strict';

Iris.Util.loadHospitals = function() {
  return $.ajax({
    url: '/dabo_admin/accounts/new',
    dataType: 'html',
    data: {
      account: {
        'virtual_system_gid': $('.system_selection option:selected').val()
      }
    }
  }).success(function(response) {
    $('.default_hospital').html(response);
  });
};
