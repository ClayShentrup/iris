'use strict';

function stubAjaxRequest(requestURL, fixturePath) {
  var data;
  withoutMockAjax(function() {
    data = readFixtures(fixturePath);
  });

  jasmine.Ajax.stubRequest(requestURL)
  .andReturn({
    status: 200,
    responseText: data
  });
}
