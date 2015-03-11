// jshint nonew: false
'use strict';

describe('SessionsView', function() {
  describe('clicking the Cancel button', function() {
    var loginFields;
    var cancelButton;

    beforeEach(function() {
      loadFixture(
        'users-sessions_controller'
      );
      new Iris.Views['sessions-new']({el: '#body'});

      loginFields = $('input.form_control');
      cancelButton = $('.cancel_btn');
    });

    it('clears login fields', function() {
      loginFields.val('test value');
      cancelButton.click();

      expect(loginFields.val()).toBe('');
    });
  });
});
