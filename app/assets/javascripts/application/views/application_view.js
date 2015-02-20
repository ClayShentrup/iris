'use strict';

Iris.Views.application = Backbone.View.extend({
  events: {
    'click #top_nav .hide_on_desktop .icon' : 'expandSearchBox',
    'click #top_nav .search .icon_search'   : 'searchClick',
    'click #top_nav .search .icon_close'    : 'toggleCloseIcon',
    'focus #top_nav .search input'          : 'toggleSearchIcon',
    'click #feedback_bar .icon'             : 'dismissFlashMessage'
  },

  expandSearchBox: function() {
    $('#top_nav .search.hide_on_tablet_portrait.hide_on_desktop input')
      .toggle();
    $('#top_nav .nav_btns').toggle();
    this.enterSearchInputFocus();
  },

  searchClick: function() {
    this.toggleSearchIcon();
    this.enterSearchInputFocus();
  },

  toggleCloseIcon: function() {
    $('#top_nav .search .icon_close')
      .addClass('hidden');
    $('#top_nav .search input').val('').blur();
    $('#top_nav .search .icon_search')
      .removeClass('hidden');
  },

  toggleSearchIcon: function() {
    $('#top_nav .search .icon_search')
      .addClass('hidden');
    $('#top_nav .search .icon_close')
      .removeClass('hidden');
  },

  enterSearchInputFocus: function() {
    // TODO: needs to be split mobile and desktop
    // because focus can not be called on 2 elements
    $('#top_nav .search input').focus();
  },

  dismissFlashMessage: function() {
    $('#feedback_bar').hide();
  }
});
