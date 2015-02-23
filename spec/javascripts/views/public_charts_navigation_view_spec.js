'use strict';

describe('PublicChartsNavigationView', function() {
  describe('for measures', function() {
    beforeEach(function() {
      loadFixture(
        'public_charts_controller-get-show-for_measure'
      );
    });

    it('shows sibling measures', function() {
      var measuresNavContainer = $('#measures_nav_container');

      expect(measuresNavContainer).toContainText('Heart Failure Mortality');
      expect(measuresNavContainer)
        .toContainText('Acute Myocardial Infarction Mortality');
      expect(measuresNavContainer).toContainText('Pneumonia Mortality');
    });

    it('shows selected measure without arrow', function() {
      var currentNode = $('.measures_nav_current_node');
      expect(currentNode).toContainText('Pneumonia Mortality');
      expect(currentNode).not.toContainElement('a');
      expect(currentNode).not.toContainElement('svg');
    });

    it('shows sibling measure with link and arrow', function() {
      var siblingNode = $('.measures_nav_btn.forward_btn');
      expect(siblingNode).toContainText('Heart Failure Mortality');
      expect(siblingNode).toContainElement('a');
      expect(siblingNode).toContainElement('svg');
    });
  });

  describe('for non-measures', function() {
    beforeEach(function() {
      loadFixture(
        'public_charts_controller-get-show-for_value-based-purchasing'
      );
    });

    it('does not show sibling nodes', function() {
      var measuresNavContainer = $('#measures_nav_container');
      expect(measuresNavContainer).toContainText('Value Based Purchasing');
      expect(measuresNavContainer)
        .not.toContainText('Hospital Acquired Conditions');
    });

    it('shows children nodes', function() {
      var measuresNavContainer = $('#measures_nav_container');
      expect(measuresNavContainer).toContainText('Outcome of Care');
    });
  });
});
