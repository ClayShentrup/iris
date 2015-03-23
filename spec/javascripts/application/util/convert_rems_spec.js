'use strict';

describe('Iris.Util.convertPixelsToRems', function() {
  it('returns correct rem value', function() {
    expect(Iris.Util.convertPixelsToRems(60)).toBe('3.75rem');
  });
});
