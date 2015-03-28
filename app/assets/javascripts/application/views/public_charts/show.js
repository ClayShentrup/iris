// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.provider': '_toggleDropdownProvider',
    'click .dropdown_button.compare': '_toggleDropdownCompare',
    'click .dropdown_items.compare li': '_selectCompare',
    'keydown input': '_preventEnterFromSubmitting',
    'click .search_box .icon_close' : '_closeSearchProvider',
    'ajax:before #new_conversation, #new_comment': 'checkDisabled',
    'ajax:beforeSend #new_conversation, #new_comment': 'checkDisabled',
    'ajax:send #new_conversation, #new_comment': 'checkDisabled',
    'ajax:success #new_conversation, #new_comment, .foobar': 'checkDisabled',
    'ajax:success #new_conversation, #new_comment': '_handleSuccessfulSubmit',
    'ajax:error #new_conversation': '_insertErrorConversationForm',
    'ajax:error #new_comment': '_insertErrorCommentForm',
    'click #conversation_title' : '_showConversationForm',
    'click .conversation_cancel' : '_hideConversationForm',
    'click .new_comment_link a' : '_handleCommentForm',
    'click .comment_cancel': '_reloadPage',
  },

  initialize: function() {
    _.bindAll(this, '_autocompleteSource');

    this._searchBoxInput().autocomplete({
      source: this._autocompleteSource
    });
  },

  checkDisabled: function(event) {
    console.log(
      event.type,
      $(event.currentTarget).find('input:submit').prop('disabled')
    );
  },

  _showConversationForm: function(event) {
    this.$('#form_description').show();
  },

  _hideConversationForm: function(event) {
    this.$('#form_description').hide();
    this.$('#conversation_title').val('');
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

  _handleSuccessfulSubmit: function(event) {
    $(event.currentTarget).hide();
    this._reloadPage();
  },

  _reloadPage: function() {
    Turbolinks.visit(location.toString());
  },

  _insertErrorConversationForm: function(_e, data, _status, _xhr) {
    this._newConversationForm().replaceWith(data.responseText);
    $('#form_description').show();
  },

  _insertErrorCommentForm: function(_e, data, _status, _xhr) {
    this._newCommentContainer().replaceWith(data.responseText);
  },

  _newConversationForm: function() {
    return this.$('#new_conversation');
  },

  _newCommentForm: function() {
    return this.$('#new_comment');
  },

  _newCommentContainer: function() {
    return this.$('#new_comment_container');
  },

  _handleCommentForm: function(event) {
    event.preventDefault();
    var conversationId = $(event.target).data('conversation-id');
    this._setCommentFormConversationId(conversationId);
    this._newCommentContainer().show();
    this._hideNewConversationForm();
    this._hideOtherConversations(conversationId);
  },

  _setCommentFormConversationId: function(conversationId) {
    this._newCommentForm()
      .find('#comment_conversation_id').val(conversationId);
  },

  _hideNewConversationForm: function() {
    this._newConversationForm().hide();
  },

  _hideOtherConversations: function(conversationId) {
    var otherConversationsSelector =
      '.conversation_container[data-conversation-id!="' + conversationId + '"]';
    this.$(otherConversationsSelector).hide();
  }
});
