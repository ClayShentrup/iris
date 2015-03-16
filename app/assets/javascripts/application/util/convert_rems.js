'use strict';

Iris.Util.convertRems = function(pixels) {
  var computedStyles   = window.getComputedStyle($('html')[0]);
  var computedFontSize = computedStyles.fontSize;
  var baseFontSize     = parseInt(computedFontSize);

  return parseInt(pixels) / baseFontSize;
};
