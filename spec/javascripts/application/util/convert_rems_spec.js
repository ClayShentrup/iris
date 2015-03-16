'use strict';

describe('Iris.Util.convertRems', function() {
  it('returns correct rem value', function() {
    expect(Iris.Util.convertRems(60)).toBe(3.75);
  });
});
