/**
 * This ensures that our JavaScript doesn't set global variables.
 */

beforeEach(function () {
  this.windowKeys = _.keys(window);
});

afterEach(function () {
  expect(_.difference(
    _.keys(window),
    this.windowKeys
  )).toEqual([]);
});
