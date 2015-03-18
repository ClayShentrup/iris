/* global itBehavesLikeAPasswordInputField */
'use strict';

describe('UserPasswordExpiredShow', function() {
  beforeEach(function() {
    loadFixture('users-password_expired_controller-get-show');
  });

  itBehavesLikeAPasswordInputField();

});
