// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.provider': '_toggleDropdownProvider',
    'click .dropdown_button.compare': '_toggleDropdownCompare',
    'click .dropdown_items.compare li': '_selectCompare',
    'keydown input': '_preventEnterFromSubmitting',
    'click .search_box .icon_close' : '_closeSearchProvider',
    'ajax:success #new_conversation, #new_comment': '_handleSuccessfulSubmit',
    'ajax:success .cancel_btn': '_replaceConversationsContainer',
    'click #conversation_title' : '_showConversationForm',
    'ajax:success #new_conversation': '_replaceConversationsContainer',
    'ajax:error #new_conversation': '_insertErrorConversationForm',
    'ajax:success #new_comment': '_replaceConversationsContainer',
    'ajax:error #new_comment': '_insertErrorCommentForm',
    'ajax:success .new_comment_link': '_replaceConversationsContainer',
  },

  initialize: function() {
    _.bindAll(this, '_autocompleteSource');

    this._searchBoxInput().autocomplete({
      source: this._autocompleteSource
    });
  },

  _preventEnterFromSubmitting: function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      return false;
    }
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

  _closeSearchProvider: function() {
    this._searchResults().empty();
    this._searchBoxInput().val('');
    this._toggleDropdownProvider();
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

  _searchEndpoint: function(requestTerm) {
    // TODO: Get this from a path helper in the Rails template
    return '/provider_search_results/?term=' + encodeURIComponent(requestTerm);
  },

  _replaceConversationsContainer: function(event, data) {
    this._conversationsContainer().html(data);
  },

  _conversationsContainer: function() {
    return $('#conversations');
  },

  _handleSuccessfulSubmit: function(event, data) {
    $(event.currentTarget).hide();
    this._replaceConversationsContainer(event, data);
  },

  _showConversationForm: function(event) {
    this.$('#form_description').show();
  },

  _insertErrorConversationForm: function(_e, data, _status, _xhr) {
    this._newConversationForm().replaceWith(data.responseText);
    $('#form_description').show();
  },

  _insertErrorCommentForm: function(_e, data, _status, _xhr) {
    this._newCommentForm().replaceWith(data.responseText);
  },

  _newConversationForm: function() {
    return this.$('#new_conversation');
  },

  _newCommentForm: function() {
    return this.$('#new_comment');
  },
});
