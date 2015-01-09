/* jshint devel: true */
// When developing, this tells us whether the page reload was a "real" browser
// reload, or a simulated load using Turbolinks
'use strict';

$(document).on('ready', function() {
  console.log('Full page refresh.');
});

$(document).on('page:load', function() {
  console.log('Turbolinks simulated page load.');
});
