// jshint nonew: false
'use strict';

Iris.Views['layouts/application'] = Backbone.View.extend({
  events: {
    'click #feedback_bar .icon' : 'dismissFlashMessage'
  },

  initialize: function() {
    this._initializeMetricsSearch();
    this._initializeSticky();
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
  },

  _initializeSticky: function() {
    var lastStickyElement = this._stickyElements().last();

    lastStickyElement.next().css(
      'margin-top',
      this._convertPixelsToRems(this._stickyElementsTotalHeight())
    );
  },

  _stickyElements: function() {
    return $('.is_sticky:visible');
  },

  _stickyElementsTotalHeight: function() {
    if (this._stickyElements().length === 1) {
      return this._stickyElements().height();
    }

    var height = 20;
    var stickyElements = this._stickyElements();

    for (var i = 0; i < stickyElements.length; i++) {
      height += $(stickyElements[i]).height();
    }

    return height;
  },

  _convertPixelsToRems: function(value) {
    return Iris.Util.convertPixelsToRems(value) + 'rem';
  },
 });
