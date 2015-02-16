// jshint devel: true
'use strict';

Iris.Views['public_charts-show'] = Backbone.View.extend({
  events: {
    'click .dropdown_button.hospital': '_toggleDropdownHospital',
    'click .dropdown_button.compare': '_toggleDropdownCompare',
    'click .dropdown_items.hospital li': '_clickAutoselectItem'
  },

  initialize: function() {
    // for future feature (search_box_ajax will change to search_box)
    var search = $('.search_box_ajax input').autocomplete({
      source: function(request, response) {
        var ul = $('.dropdown_items.hospital ul');
        $.get('/search/hospitals/?term=' + request.term, function(result) {
          _.each(result, function(item) {
            var li = $('<li>')
              .addClass('bottom_buffer_small link')
              .attr('data-value', item.id)
              .appendTo(ul);

            $('<p>').html(item.name).addClass('no_margin')
            .appendTo(li);

            $('<p>').html(item.city + ', ' + item.state).addClass('text_muted')
            .appendTo(li);

            response([]);
          });
        });
      }
    });

  },

  _toggleDropdownHospital: function() {
    this._selectAndCompare()
    .removeClass('show_compare')
    .toggleClass('show_hospital');
  },

  _toggleDropdownCompare: function() {
    this._selectAndCompare()
    .removeClass('show_hospital')
    .toggleClass('show_compare');
  },

  _selectAndCompare: function() {
    return this.$('#select_and_compare');
  },

  _clickAutoselectItem: function(event) {
    return false; // for future feature
    // var name = $(event.currentTarget).find('p:first').text();
    // $('.hospital_name').html(name);
    // this._toggleDropdownHospital();
  }

});
