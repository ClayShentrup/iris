'use strict';

function loadFixture(fixturePath) {
  withoutMockAjax(function() {
    loadFixtures(fixturePath + '.html');
  });
}
