/* global itBehavesLikeAPasswordInputField */
'use strict';

describe('PasswordFieldView', function() {
  beforeEach(function() {
    loadFixture('users-sessions_controller');
  });

  itBehavesLikeAPasswordInputField();
});
