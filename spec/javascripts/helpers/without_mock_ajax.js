'use strict';

var withoutMockAjax = function(callback){
  try {
    jasmine.Ajax.uninstall();
    return callback();
  } finally {
    jasmine.Ajax.install();
  }
};
