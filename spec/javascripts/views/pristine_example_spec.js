'use strict';

describe('PristineExampleIndexView', function() {
  var view;

  beforeEach(function() {
    view = new Iris.Views['pristine_examples-index']();
  });

  describe('when view is constructing', function() {
    it('should exist', function() {
      expect(view).toBeDefined();
    });
  });

  describe('rendered elements on page', function() {
    it('has the new pristine example link', function() {
      loadFixture(
        'pristine_examples_controller-get-index-with-feature-enabled'
      );
      expect($('#body a[href="/pristine_examples/new"]'))
        .toContainText('New Pristine example');
    });
  });
});
