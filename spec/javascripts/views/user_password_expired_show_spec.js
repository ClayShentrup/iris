/* global itBehavesLikeAPasswordInputField */
/* global itBehavesLikeAPasswordConfirmationInputField */
'use strict';

describe('UserPasswordExpiredShow', function() {
  beforeEach(function() {
    loadFixture('users-password_expired_controller');
  });

  itBehavesLikeAPasswordInputField();
  itBehavesLikeAPasswordConfirmationInputField();
});
