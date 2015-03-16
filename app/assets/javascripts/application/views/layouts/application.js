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
    this._initializeTopNav();
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

  /*
   * Sticky Top Nav
   */

  _initializeTopNav: function() {
    _.bindAll(this, '_scrolling');
    this._window().scroll(this._scrolling);
    this._startingPosition = 0;
  },

  _window: function() {
    return this.options.window || $(window);
  },

  _topNav: function() {
    return $('#top_nav');
  },

  _scrollPosition: function() {
    return this._window().scrollTop();
  },

  _lastPosition: 0,

  _startingPosition: 0,

  _navPos: function() {
    return this._topNav().position().top;
  },

  _setTopNavPos: function(pos) {
    this._topNav().css('top', Iris.Util.convertRems(pos) + 'rem');
  },

  _topNavHeight: function() {
    return this._topNav().height();
  },

  _scrolling: function() {
    var scrollPosition = this._scrollPosition();
    var negativeHeight = -this._topNavHeight();

    if (this._topNav().length === 0) {
      return;
    }

    if (this._navPos() < negativeHeight) {
      // chrome's scroll returning on refresh
      this._setTopNavPos(negativeHeight);
    }

    if (scrollPosition > this._lastPosition) {
      // scrolling down
      if (this._navPos() > negativeHeight) {
        this._setTopNavPos(
          this._lastPosition - scrollPosition + this._navPos()
        );
      } else {
        this._setTopNavPos(negativeHeight);
      }
    } else {
      // scrolling up
      if (this._navPos() < this._startingPosition) {
        this._setTopNavPos(
          this._lastPosition - scrollPosition + this._navPos()
        );
      } else {
        this._setTopNavPos(this._startingPosition);
      }
    }
    this._lastPosition = scrollPosition;
  },


 });
