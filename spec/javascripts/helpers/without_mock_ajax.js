'use strict';

var withoutMockAjax = function(callback){
  try {
    jasmine.Ajax.uninstall();
    callback();
  } finally {
    jasmine.Ajax.install();
  }
};
