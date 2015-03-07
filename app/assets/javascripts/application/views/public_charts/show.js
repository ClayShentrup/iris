// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.provider': '_toggleDropdownProvider',
    'click .dropdown_button.compare': '_toggleDropdownCompare',
    'click .dropdown_items.provider li': '_selectProvider',
    'click .dropdown_items.compare li': '_selectCompare',
    'keydown input': '_preventEnterFromSubmitting',
    'click .search_box .icon_close' : '_closeSearchProvider'
  },

  initialize: function() {
    _.bindAll(this, '_autocompleteSource');

    this._searchBoxInput().autocomplete({
      source: this._autocompleteSource
    });
  },

  _searchBoxInput: function() {
    return this.$('.search_box input');
  },

  _autocompleteSource: function(request, response) {
    this._searchResults().load(this._searchEndpoint(request.term));
    response([]);
  },

  _searchResults: function() {
    return this.$('.dropdown_items.provider ul');
  },

  _toggleDropdownProvider: function() {
    this._selectAndCompare()
    .removeClass('show_compare')
    .toggleClass('show_provider');
  },

  _toggleDropdownCompare: function() {
    this._selectAndCompare()
    .removeClass('show_provider')
    .toggleClass('show_compare');
  },

  _selectAndCompare: function() {
    return this.$('#select_and_compare');
  },

  _selectProvider: function(event) {
    var selectedProvider = $(event.currentTarget);
    var name = selectedProvider.data('provider-name');
    var cityAndState = selectedProvider.data('provider-city-and-state');

    this.$('.provider_name').html(name);
    this.$('.compare_name').html(cityAndState);

    this._toggleDropdownProvider();
    this._refreshCompareDropdown(selectedProvider.data('provider-id'));
  },

  _selectCompare: function(event) {
    var selectedCompare = $(event.currentTarget);
    var name = selectedCompare.find('.compare_item_name').html();

    this.$('.compare_name').html(name);

    this._toggleDropdownCompare();
  },

  _refreshCompareDropdown: function(providerId) {
    this._compareResults().load(this._compareEndpoint(providerId));
  },

  _compareResults: function() {
    return this.$('.dropdown_items.compare ul');
  },

  _compareEndpoint: function(providerId) {
    // TODO: Get this from a path helper in the Rails template
    return '/provider_search_results/' + providerId;
  },

  _searchEndpoint: function(requestTerm) {
    // TODO: Get this from a path helper in the Rails template
    return '/provider_search_results/?term=' + encodeURIComponent(requestTerm);
  },

  _preventEnterFromSubmitting: function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      return false;
    }
  },

  _closeSearchProvider: function() {
    this._searchResults().empty();
    this._searchBoxInput().val('');
    this._toggleDropdownProvider();
  }

});
