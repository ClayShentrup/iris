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

      expect(loginFields).toHaveValue('');
    });
  });

  describe('toggling password masking', function() {
    var view;
    var passwordField;
    var toggleIcon;
    var setPassword = function(password) {
      passwordField.val(password).change();
    };

    beforeEach(function() {
      view = new Iris.Views.passwordField({el: '.toggle_password'});
      passwordField = $('#user_password');
      toggleIcon = $('.toggle_password .icon');
    });

    describe('with text in password input', function() {
      beforeEach(function() {
        setPassword('password');
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
        setPassword('');
      });

      it('eye icon is hidden', function() {
        expect(toggleIcon).toBeHidden();
      });
    });

    it('does not allow to paste text', function() {
      var pasteEvent;
      passwordField.on('paste', function(event) {
        pasteEvent = event;
      });
      passwordField.trigger('paste');
      expect(pasteEvent.isDefaultPrevented()).toBe(true);
    });
  });

  describe('tabs', function() {
    beforeEach(function() {
      new Iris.Views['sessions-new']({el: '#body'});
    });

    var expectLoginTab = function() {
      expect('#login').toBeVisible();
      expect('#signup').not.toBeVisible();
    };

    var expectSignupTab = function() {
      expect('#login').not.toBeVisible();
      expect('#signup').toBeVisible();
    };

    it('initially shows the login tab', function() {
      expectLoginTab();
    });

    it('displays the selected tab', function() {
      $('li a[href="#signup"]').click();
      expectSignupTab();
      $('li a[href="#login"]').click();
      expectLoginTab();
    });
  });
});
