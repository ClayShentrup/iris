'use strict';

Iris.Views.application = Backbone.View.extend({
  events: {
    'click #top_nav .hide_on_desktop .icon' : 'expandSearchBox',
    'click #top_nav .search .icon_search'   : 'searchClick',
    'click #top_nav .search .icon_close'    : 'toggleCloseIcon',
    'focus #top_nav .search input'          : '_handleInputFocus',
    'blur #top_nav .search input'           : '_handleInputBlur',
    'click #feedback_bar .icon'             : 'dismissFlashMessage',
    'keydown #top_nav .search input'        : '_toggleSearchResults'
  },

  initialize: function() {
    _.bindAll(this, '_autocompleteSource');

    $('.search_results').hide();
    this.$('#top_nav .search input').autocomplete({
      source: this._autocompleteSource
    });
  },

  _handleInputFocus: function() {
    this._toggleSearchIcon();
    this._fadeOutBackground();
  },

  _handleInputBlur: function() {
    this._fadeInBackground();
    this._searchResults().hide();
  },

  _autocompleteSource: function(request, response) {
    this._searchResults().load(this._searchEndpoint(request.term));
    response([]);
  },

  _toggleSearchResults: function(e) {
    var input = $(e.currentTarget);
    if (input.val() === '') {
      this._mainContent().css('opacity', 0.5);
      this._searchResults().hide();
    } else {
      this._mainContent().css('opacity', 0);
      this._searchResults().show();
    }
  },

  _searchEndpoint: function(term) {
    return '/measures_search_results/?term=' + encodeURIComponent(term);
  },

  _searchResults: function() {
    return this.$('.search ul.results');
  },

  _mainContent: function() {
    return this.$('.main_content');
  },

  expandSearchBox: function() {
    $('#top_nav .search.hide_on_tablet_portrait.hide_on_desktop input')
      .toggle();
    $('#top_nav .nav_btns').toggle();
    this.enterSearchInputFocus();
  },

  searchClick: function() {
    this._toggleSearchIcon();
    this.enterSearchInputFocus();
  },

  toggleCloseIcon: function() {
    $('#top_nav .search .icon_close')
      .addClass('hidden');
    $('#top_nav .search input').val('').blur();
    $('#top_nav .search .icon_search')
      .removeClass('hidden');
  },

  _toggleSearchIcon: function() {
    $('#top_nav .search .icon_search')
      .addClass('hidden');
    $('#top_nav .search .icon_close')
      .removeClass('hidden');
  },

  _fadeOutBackground: function() {
    this._mainContent().css('opacity', 0.5);
  },

  _fadeInBackground: function() {
    this._mainContent().css('opacity', '');
  },

  enterSearchInputFocus: function() {
    $('#top_nav .search input').focus();
  },

  dismissFlashMessage: function() {
    $('#feedback_bar').hide();
  }
});
