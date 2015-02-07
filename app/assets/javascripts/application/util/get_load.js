'use strict';

Iris.Util.getLoad = function(selector, url, params) {
  return $.ajax({
    url: url,
    dataType: 'html',
    data: params
  }).success(function(response) {
    $(selector).html(response);
  });
};
