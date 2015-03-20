// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.provider': '_toggleDropdownProvider',
    'click .dropdown_button.compare': '_toggleDropdownCompare',
    'click .dropdown_items.compare li': '_selectCompare',
    'keydown input': '_preventEnterFromSubmitting',
    'click .search_box .icon_close' : '_closeSearchProvider',
    'ajax:success #new_conversation': '_reloadPage',
    'ajax:error #new_conversation': '_insertErrorConversationForm'
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

  _selectCompare: function(event) {
    var selectedCompare = $(event.currentTarget);
    var name = selectedCompare.find('.compare_item_name').html();

    this.$('.compare_name').html(name);

    this._toggleDropdownCompare();
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
  },

  _reloadPage: function(_e, data, _status, _xhr) {
    Turbolinks.visit('/metrics/' + this._currentNodeId());
  },

  _currentNodeId: function() {
    return this._nodeContainer().data('current-node-id');
  },

  _nodeContainer: function() {
    return this.$('#node_container');
  },

  _insertErrorConversationForm: function(_e, data, _status, _xhr) {
    this._newConversationForm().html(data.responseText);
  },

  _newConversationForm: function() {
    return $('#new_conversation');
  },
});
