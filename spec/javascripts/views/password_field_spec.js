'use strict';

describe('PasswordFieldView', function() {
  var view;
  var passwordField;
  var toggleIcon;

  beforeEach(function() {
    loadFixture('devise-sessions_controller');
    view = new Iris.Views.passwordField({el: '#body'});
    passwordField = $('#user_password');
    toggleIcon = $('.icon.toggle_password');
  });

  describe('password mask toggle', function() {
    it('show eye icon', function() {
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

  it('does not allow to paste text', function() {
    spyOn(view, '_disablePaste');
    view.delegateEvents();

    passwordField.trigger('paste');

    expect(view._disablePaste).toHaveBeenCalled();
  });
});
