'use strict';

function searchAutocomplete(input, searchTerm) {
  var jQueryAutocompleteDelay = 300;
  input.val(searchTerm).keydown();
  jasmine.clock().tick(jQueryAutocompleteDelay);
  //jasmine.clock().tick(); // because jQuery autocomplete uses setTimeout()
}
