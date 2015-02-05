// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.hospital': '_toggleDropdownHospital',
    'click .dropdown_button.compare': '_toggleDropdownCompare'
  },

  _toggleDropdownHospital: function() {
    this._selectAndCompare()
    .removeClass('show_compare')
    .toggleClass('show_hospital');
  },

  _toggleDropdownCompare: function() {
    this._selectAndCompare()
    .removeClass('show_hospital')
    .toggleClass('show_compare');
  },

  _selectAndCompare: function() {
    return this.$('#select_and_compare');
  }
});
