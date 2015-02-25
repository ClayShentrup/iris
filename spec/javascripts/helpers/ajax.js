'use strict';

function stubAjaxRequest(requestURL, fixturePath) {
  var data = withoutMockAjax(function() {
    return readFixtures(fixturePath);
  });
  jasmine.Ajax.stubRequest(requestURL)
  .andReturn({
    status: 200,
    responseText: data
  });
}

/*
jQuery's AJAX handler normally fires the callback in a setTimeout
in order to make it occur in the next tick of the event loop. This
forces us to use `jasmine.clock().tick()` in tests. By making AJAX
synchronous, the callbacks fire immediately.
*/
$.ajaxSetup({async: false});
