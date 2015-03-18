'use strict';

function itBehavesLikeAPasswordInputField() {
  _passwordInputFieldSpecs('#user_password');
}

function _passwordInputFieldSpecs(targetPasswordField) {
  var view;
  var passwordField;
  var toggleIcon;

  beforeEach(function() {
    passwordField = $(targetPasswordField);
    view = new Iris.Views.passwordField({el: passwordField.parent()});
    toggleIcon = passwordField.next('.toggle_password .icon');
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
}
