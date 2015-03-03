'use strict';

function searchAutocomplete(input, searchTerm) {
  var jQueryAutocompleteDelay = 300;
  input.val(searchTerm).keydown().keyup();
  jasmine.clock().tick(jQueryAutocompleteDelay);
}
