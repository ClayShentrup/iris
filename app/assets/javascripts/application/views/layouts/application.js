// jshint nonew: false
'use strict';

Iris.Views['layouts/application'] = Backbone.View.extend({
  events: {
    'click .feedback_bar .icon' : 'dismissFlashMessage',
    'click #top_nav .menu_icon' : '_toggleLeftNav',
    'click .sidebar_offcanvas'  : '_toggleLeftNav',
    'click .inner_content_offcanvas.concealed' : '_toggleLeftNav',
  },

  initialize: function() {
    this._initializeMetricsSearch();
    this._initializeSticky();
  },

  _initializeMetricsSearch: function() {
    new Iris.Views['layouts/search_form']({
      applicationView: this,
      el: this.$('#top_nav')
    });
  },

  dismissFlashMessage: function() {
    $('.feedback_bar').hide();
  },

  lightenBackground: function() {
    this._setInnerContentOpacity(0.5);
  },

  showBackground: function() {
    this._setInnerContentOpacity(1);
  },

  hideBackground: function() {
    this._setInnerContentOpacity(0);
  },

  _setInnerContentOpacity: function(opacity) {
    this._innerContent().css('opacity', opacity);
  },

  _innerContent: function() {
    return this.$('.inner_content');
  },

  _initializeSticky: function() {
    var lastStickyElement = this._stickyElements().last();

    lastStickyElement.after('<div class="spacer"/>');
    $('.spacer').css(
      'height',
      Iris.Util.convertPixelsToRems(this._stickyElementsTotalHeight())
    );
  },

  _stickyElements: function() {
    return $('.is_sticky:visible');
  },

  _stickyElementsTotalHeight: function() {
    var height = 30;
    var stickyElements = this._stickyElements();

    for (var i = 0; i < stickyElements.length; i++) {
      height += $(stickyElements[i]).height();
    }

    return height;
  },

  _toggleLeftNav: function() {
    this._sidebarOffcanvas().toggleClass('expanded');
    this._innerContentOffcanvas().toggleClass('concealed');
  },

  _sidebarOffcanvas: function() {
    return $('.sidebar_offcanvas');
  },

  _innerContentOffcanvas: function() {
    return $('.inner_content_offcanvas');
  }
 });
