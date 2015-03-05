// jshint nonew: false
'use strict';

Iris.Views['layouts/application'] = Backbone.View.extend({
  events: {
    'click #feedback_bar .icon' : 'dismissFlashMessage'
  },

  initialize: function() {
    this._initializeMetricsSearch();
  },

  _initializeMetricsSearch: function() {
    new Iris.Views['layouts/search_form']({
      applicationView: this,
      el: this.$('#top_nav .search.hide_on_mobile')
    });
    new Iris.Views['layouts/search_form']({
      applicationView: this,
      el: this.$('#top_nav .search.hide_on_desktop')
    });
  },

  dismissFlashMessage: function() {
    $('#feedback_bar').hide();
  },

  lightenBackground: function() {
    this._setContentOpacity(0.5);
  },

  showBackground: function() {
    this._setContentOpacity(1);
  },

  hideBackground: function() {
    this._setContentOpacity(0);
  },

  toggleNavButtonsAndResizeSearchBar: function(show) {
    this.$('.nav_btns').toggleClass('hidden', !show);
    this.$('.top_nav_spacer').toggleClass('hidden', !show);
    this.$('.search').toggleClass('search_starting_width', show);
  },

  _setContentOpacity: function(opacity) {
    this._mainContent().css('opacity', opacity);
  },

  _mainContent: function() {
    return this.$('.main_content');
  }

});
