describe('PristineExampleIndexView', function() {
  var view;

  beforeEach(function() {
    view = new Dabo.Views['pristine_examples-index']();
  });

  describe('when view is constructing', function() {
    it('should exist', function() {
      expect(view).toBeDefined();
    });
  });
});
