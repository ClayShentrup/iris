/**
 * This ensures that our JavaScript doesn't use unstubbed AJAX calls
 */

beforeEach(function() {
  jasmine.Ajax.install();
});
