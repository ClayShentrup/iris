// jshint devel: true
'use strict';

Iris.Views['news_feeds-show'] = Backbone.View.extend({
  initialize: function() {
    $('#news_feed_filter').on('click', function() {
      $('.unselected').slideToggle(100);
      $('.selected_item').addClass('.news_feed_filter_item');
    });
    $('.news_feed_filter_item .icon_and_text').click(function() {
      var clickedItem = $(this);
      var selectedItem = $('.selected_item .icon_and_text');
      var clickedItemContent = $(this).html();
      var selectedItemContent = $('.selected_item .icon_and_text').html();

      $(selectedItem).html(clickedItemContent);
      $(clickedItem).html(selectedItemContent);
    });
  }
});
