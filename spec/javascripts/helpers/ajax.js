'use strict';

function stubAjaxRequestWithData(requestURL, data, status) {
  jasmine.Ajax.stubRequest(requestURL)
  .andReturn({
    status: status,
    responseText: data,
    contentType: 'application/html'
  });
}

function stubSuccessfulAjaxRequestWithData(requestURL, data) {
  stubAjaxRequestWithData(requestURL, data, 200);
}

function dataForFixturePath(fixturePath) {
  return withoutMockAjax(function() {
    return readFixtures(fixturePath);
  });
}

function stubAjaxRequestNoFixture(requestURL) {
  stubSuccessfulAjaxRequestWithData(requestURL, '');
}

function stubAjaxRequestWithStatus(requestURL, fixturePath, status) {
  stubAjaxRequestWithData(requestURL, dataForFixturePath(fixturePath), status);
}

var stubAjaxRequest = function(requestURL, fixturePath) {
  stubSuccessfulAjaxRequestWithData(
    requestURL,
    dataForFixturePath(fixturePath)
  );
};

/*
jQuery's AJAX handler normally fires the callback in a setTimeout
in order to make it occur in the next tick of the event loop. This
forces us to use `jasmine.clock().tick()` in tests. By making AJAX
synchronous, the callbacks fire immediately.
*/
$.ajaxSetup({async: false});
