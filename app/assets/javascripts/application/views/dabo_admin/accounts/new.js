// jshint devel: true
// jscs:disable
// jshint camelcase: false

'use strict';

Iris.Views['accounts-new'] = Backbone.View.extend({
  initialize: function() {
    $(document).ready(function() {
      $('.system_selection').change(function() {
        $('.default_hospital').load(
          '/dabo_admin/accounts/system_hospitals',
          {virtual_system_id: $('.system_selection option:selected').val()}
        );
      });
    });
  }
});
