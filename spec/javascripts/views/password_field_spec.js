'use strict';

describe('PasswordFieldView', function() {
  var view;
  var passwordField;
  var toggleIcon;

  beforeEach(function() {
    loadFixture('devise-sessions_controller');
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
