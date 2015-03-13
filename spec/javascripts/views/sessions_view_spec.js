// jshint nonew: false
'use strict';

describe('SessionsView', function() {
  beforeEach(function() {
    loadFixture(
      'users-sessions_controller'
    );
  });

  describe('clicking the Cancel button', function() {
    var loginFields;
    var cancelButton;

    beforeEach(function() {
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

  describe('toggling password masking', function() {
    var view;
    var passwordField;
    var toggleIcon;

    beforeEach(function() {
      view = new Iris.Views.passwordField({el: '.toggle_password'});
      passwordField = $('#user_password');
      toggleIcon = $('.toggle_password .icon');
    });

    describe('with text in password input', function() {
      beforeEach(function() {
        passwordField.val('password').change();
      });

      it('shows eye icon', function() {
        expect(toggleIcon).toBeVisible();
      });

      it('eye icon toggles password mask', function() {
        expect(passwordField).toHaveAttr('type', 'password');
        toggleIcon.click();
        expect(passwordField).toHaveAttr('type', 'text');
        toggleIcon.click();
        expect(passwordField).toHaveAttr('type', 'password');
      });
    });

    describe('without text in password input', function() {
      beforeEach(function() {
        passwordField.val('').change();
      });

      it('eye icon is hidden', function() {
        expect(toggleIcon).toBeHidden();
      });
    });

    it('does not allow to paste text', function() {
      spyOn(view, '_disablePaste');
      view.delegateEvents();

      passwordField.trigger('paste');

      expect(view._disablePaste).toHaveBeenCalled();
    });
  });
});
