'use strict';

Iris.Views.application = Backbone.View.extend({
  events: {
    'click #top_nav .hide_on_desktop .icon' : 'expandSearchBox',
    'click #top_nav .search .icon_search'   : 'searchClick',
    'click #top_nav .search .icon_close'    : 'toggleCloseIcon',
    'focus #top_nav .search input'          : 'toggleSearchIcon'
  },

  expandSearchBox: function() {
    $('#top_nav .search.hide_on_tablet_portrait.hide_on_desktop input')
      .toggle();
    $('#top_nav .nav_btns').toggle();
    $('#top_nav .search .icon_search').addClass('icon_float_right');
  },

  searchClick: function() {
    this.toggleSearchIcon();
    this.enterSearchInputFocus();
  },

  toggleCloseIcon: function() {
    $('#top_nav .search .icon_close')
      .removeClass('icon_close')
      .addClass('icon_search');
    $('#top_nav .search.hide_on_tablet_portrait .icon_search')
      .removeClass('icon_float_right');
    $('#top_nav .search input').val('').blur();
  },

  toggleSearchIcon: function() {
    $('#top_nav .search .icon_search')
      .removeClass('icon_search')
      .addClass('icon_close');
  },

  enterSearchInputFocus: function() {
    $('#top_nav .search input').focus();
  }
});
