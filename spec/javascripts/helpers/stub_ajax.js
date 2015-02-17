'use strict';

function stubAjaxRequest(requestURL, fixturePath) {
  var data;
  withoutMockAjax(function() {
    data = getJSONFixture(fixturePath + '.json');
  });

  jasmine.Ajax.stubRequest(requestURL)
  .andReturn({
    status: 200,
    responseText: JSON.stringify(data)
  });
}
