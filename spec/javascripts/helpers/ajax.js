'use strict';

function stubAjaxRequest(requestURL, fixturePath, status) {
  var data = '';
  status = typeof status === 'undefined' ? 200 : status;

  if (typeof fixturePath !== 'undefined') {
    data = withoutMockAjax(function() {
      return readFixtures(fixturePath);
    });
  }

  jasmine.Ajax.stubRequest(requestURL)
  .andReturn({
    status: status,
    responseText: data,
    contentType: 'application/html'
  });
}

/*
jQuery's AJAX handler normally fires the callback in a setTimeout
in order to make it occur in the next tick of the event loop. This
forces us to use `jasmine.clock().tick()` in tests. By making AJAX
synchronous, the callbacks fire immediately.
*/
$.ajaxSetup({async: false});
