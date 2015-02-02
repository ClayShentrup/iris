// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button': 'toggleDropdown'
  },

  toggleDropdown: function(evt) {
    var $dropdown = $(evt.currentTarget).closest('.select_container');

    $dropdown.siblings('.open').removeClass('open');
    $dropdown.toggleClass('open');

    this.updateDropdownHeight($dropdown);
  },

  updateDropdownHeight: function(dropdown) {
    var height = 'auto';

    if (dropdown.hasClass('open')) {
      height = dropdown.find('.dropdown_button').height() +
        dropdown.find('.dropdown_items').height();
    }

    dropdown.parent().height(height);
  }
});
