// jshint nonew: false
'use strict';

Iris.Views['layouts/application'] = Backbone.View.extend({
  events: {
    'click #feedback_bar .icon' : 'dismissFlashMessage',
    'scroll' : '_scrolling'
  },

  defaults: {
    window: $(window)
  },

  initialize: function(options) {
    this.options = _.extend({}, this.defaults, options);
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
    var stickyElement = this._stickyElement();
    _.bindAll(this, '_scrolling');
    this._window().scroll(this._scrolling);
  },

  _window: function() {
    return this.options.window || $(window);
  },

  _topNav: function() {
    return $('#top_nav');
  },

  _stickyElement: function() {
    return $('.sticky_element');
  },

  _topNavHeight: function() {
    this.topNavHeight = this.topNavHeight || this._topNav().height() + 2;
    return this.topNavHeight;
  },

  _stickyElementHeight: function() {
    return this._stickyElement().height();
  },

  _elementIsReadyToBeSticky: function() {
    return this._window().scrollTop() > this._stickyElementHeight();
  },

  _scrollPosition: function() {
    if (this._window().scrollTop() >= 0) {
      return this._window().scrollTop();
    } else {
      return 44;
    }
  },

  _topNavPosition: function() {
    return this._topNav().position().top;
  },

  _revealTopNav: function() {
    this._topNav().addClass('is_sticky');
    this._stickyElement().animate({
      'top': Iris.Util.convertPixelsToRems(this._topNavHeight()) + 'rem'
    }, 300);
  },

  _hideTopNav: function() {
    this._resetTopNav();
    this._stickyElement().css('top', 0);
  },

  _resetTopNav: function() {
    this._topNav().removeClass('is_sticky');
  },

  _scrolling: function() {
    var scrollPosition = this._scrollPosition();

    if (this._elementIsReadyToBeSticky()) {
      this._stickyElement().addClass('is_sticky');
    } else {
      this._stickyElement().removeClass('is_sticky');
    }

    if (this._topNav().length === 0) {
      return;
    }

    if (scrollPosition < this._lastPosition) {
      if (scrollPosition > this._topNavHeight()) {
        if (!this._topNav().hasClass('is_sticky')) {
          this._revealTopNav();
        }
      } else {
        this._resetTopNav();
      }
    } else {
      this._hideTopNav();
    }
    this._lastPosition = scrollPosition;
  },
 });
