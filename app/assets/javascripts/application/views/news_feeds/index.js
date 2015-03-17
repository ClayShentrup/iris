// jshint devel: true
'use strict';

Iris.Views['news_items-index'] = Backbone.View.extend({

  defaults: {
    window: $(window)
  },

  initialize: function(options) {
    this.options = _.extend({}, this.defaults, options);

    if ($('#news_feed_filter .dropdown').is(':hidden')) {
      $('#news_feed_filter').on('click', function() {
        $('.dropdown').slideToggle(100);
      });
    }
    $('#news_feed_filter .hide_on_desktop').on('click', function() {
      $('#news_feed_filter .icon.icon_large.float_right')
        .toggleClass('icon_arrow_large_down icon_arrow_large_up');
    });
    this._initializeSticky();
  },

  /*
   * Stick class menu
   */

  _initializeSticky: function() {
    var stickyElement = $('.sticky_element');
    stickyElement.addClass('is_sticky');
    stickyElement.next(':visible')
      .css('margin-top',
           Iris.Util.convertPixelsToRems(stickyElement.outerHeight()) +
           Iris.Util.convertPixelsToRems(30) + 'rem');
    this._element = stickyElement;

    _.bindAll(this, '_scrolling');
    this._window().scroll(this._scrolling);

    this._startingPosition = 44;
    this._lastPosition = this._scrollPosition();

    if (this._scrollPosition() < this._startingPosition) {
      var value = this._startingPosition - this._scrollPosition();
      this._setTopNavPos(value);
    } else {
      this._setTopNavPos(0);
    }
  },

  _element: null,

  _window: function() {
    return this.options.window || $(window);
  },

  _topNav: function() {
    return this._element;
  },

  _scrollPosition: function() {
    if (this._window().scrollTop() > 0) {
      return this._window().scrollTop();
    } else {
      return;
    }
  },

  _lastPosition: 0,

  _startingPosition: 0,

  _navPos: function() {
    return this._topNav().position().top;
  },

  _setTopNavPos: function(pos) {
    this._topNav().css('top', Iris.Util.convertPixelsToRems(pos) + 'rem');
  },

  _topNavHeight: function() {
    return this._topNav().height();
  },

  _scrolling: function() {
    var scrollPosition = this._scrollPosition();
    var negativeHeight = 0;

    if (this._topNav().length === 0) {
      return;
    }

    if (scrollPosition >= this._lastPosition) {
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
