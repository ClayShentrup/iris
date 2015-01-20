'use strict';

Iris.Util.logEvent = function(eventName, eventProperties) {
  var pixelPath = $('body').data('pixel-path');
  var pixelData = {
    event: eventName,
    properties: eventProperties
  };
  var pixelDataUriString = encodeURI(
    JSON.stringify(pixelData)
  );
  var cachebuster = Math.random().toString().slice(2);
  var image = new Image();
  image.src = pixelPath +
              '?data=' +
              pixelDataUriString +
              '&cachebuster=' +
              cachebuster;
  return image;
};

$(document).on('ready page:load', function() {
  Iris.Util.logEvent('Page View', {
    currentUserId: null,
    route: document.location.pathname,
    routeParams: document.location.search
  });
});
