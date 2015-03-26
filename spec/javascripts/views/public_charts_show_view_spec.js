// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var jQueryAutocompleteDelay = 300;
  var providerDropdown;
  var searchInput;
  var searchEndpoint = '/provider_search_results/?term=';
  var oneProviderFixture =
    'provider_search_results_controller-index-generate-fixtures-' +
    'one-provider.html';
  var twoProvidersFixture =
    'provider_search_results_controller-index-generate-fixtures-' +
    'two-providers.html';
  var compareDropdown;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-generate-a-fixture-' +
      'with-conversations'
    );
    new Iris.Views['public_charts-show']({el: '#body'});

    searchInput = $('.dropdown_items.provider .search_box input');
    providerDropdown = $('.dropdown_items.provider');
  });

  it('shows compare options for default provider', function() {
    var compareDropdown = $('.dropdown_items.compare');
    var providerCityAndState = compareDropdown.find('ul li:first');
    var providerState = compareDropdown.find('ul li:nth-child(2)');
    var providerSystem = compareDropdown.find('ul li:nth-child(3)');
    var providerNation = compareDropdown.find('ul li:last');

    expect(providerCityAndState).toContainText('SAN FRANCISCO, CA');
    expect(providerCityAndState).toContainText('3 Provider');
    expect(providerState).toContainText('CA');
    expect(providerState).toContainText('3 Provider');
    expect(providerSystem).toContainText('Hospital System 2');
    expect(providerSystem).toContainText('1 Provider');
    expect(providerNation).toContainText('Nationwide');
    expect(providerNation).toContainText('3 Provider');
  });

  describe('typing into the search input', function() {
    beforeEach(function() {
      expect(providerDropdown).toBeHidden();
      $('.dropdown_button.provider').click();
      expect(providerDropdown).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'foo', twoProvidersFixture);

      searchAutocomplete(searchInput, 'foo');
      expect(providerDropdown.find('a').eq(0))
        .toHaveAttr('href', '?provider_id=99');
      expect(providerDropdown.find('a').eq(1))
        .toHaveAttr('href', '?provider_id=100');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'foo', twoProvidersFixture);

      searchAutocomplete(searchInput, 'foo');
      expect(providerDropdown.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'bar%20baz', oneProviderFixture);
      searchAutocomplete(searchInput, 'bar baz');
      expect(providerDropdown.find('li')).toHaveLength(1);
      expect(providerDropdown.find('a').eq(0))
        .toHaveAttr('href', '?provider_id=88');
    });
  });

  describe('selecting a compare option', function() {
    beforeEach(function() {
      compareDropdown = $('.dropdown_items.compare');
    });

    it('updates compare title in dropdown button', function() {
      var compareName = $('.dropdown_button.compare .compare_name');
      expect(compareName).toContainText('SAN FRANCISCO, CA');

      compareName.click();
      compareDropdown.find('li').eq(3).click();

      expect(compareName).toContainText('Nationwide');
      expect($('.dropdown_items.compare')).toBeHidden();
    });
  });

  describe('close button', function() {
    it ('clears the field and the previous search results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);
      searchAutocomplete(searchInput, 'UCSF');
      $('.dropdown_button.provider').click();

      $('.search_box .icon_close').click();

      expect($('.dropdown_items')).toBeHidden();
      $('.dropdown_button.provider').click();

      expect(searchInput).toBeEmpty();
      expect(providerDropdown.find('ul')).toBeEmpty();
    });
  });

  describe('provider dropdown button', function() {
    beforeEach(function() {
      this.dropdownButton = $('.dropdown_button.provider');
    });

    itBehavesLikeDropdownButton();
  });

  describe('compare dropdown button', function() {
    beforeEach(function() {
      this.dropdownButton = $('.dropdown_button.compare');
    });

    itBehavesLikeDropdownButton();
  });

  describe('submitting a new conversation', function() {
    var conversationTitle;
    var conversationDescription;

    beforeEach(function() {
      conversationTitle = $('#conversation_title');
      conversationDescription = $('#conversation_description');
      expect(conversationTitle).toHaveValue('');
      expect(conversationDescription).toBeHidden();
    });

    describe('with invalid inputs', function() {
      it('displays an error', function() {
        var fixtureForInvalidCreateResponse =
          'conversations_controller-post-create-with-' +
          'invalid-params-generate-a-fixture.html';

        conversationTitle.val('Something');
        conversationDescription.val('');

        stubAjaxRequest(
          '/conversations',
          fixtureForInvalidCreateResponse,
          433
        );

        $('#new_conversation').submit();
        expect($('#error_explanation_no_border')).toExist();
      });
    });

    describe('with valid inputs', function() {
      it('refreshes the page', function() {
        conversationTitle.val('Here is a title');
        conversationDescription.val('Here is a description');

        stubAjaxRequest('/conversations');

        spyOn(Turbolinks, 'visit');
        $('#new_conversation').submit();
        expect(Turbolinks.visit.calls.any()).toEqual(true);
      });
    });

    describe('cancelling a new conversation', function() {
      it('it closes the form', function() {
        conversationTitle.click();
        conversationTitle.val('A new conversation');
        expect(conversationTitle).toHaveValue('A new conversation');
        expect(conversationDescription).toBeVisible();

        $('.conversation_cancel').click();
        expect(conversationTitle).toHaveValue('');
        expect(conversationDescription).toBeHidden();
      });
    });
  });

  describe('submitting a new comment', function() {
    beforeEach(function() {
      expect($('#new_comment_container')).toBeHidden();
      $('.new_comment_link a').first().click();
      expect($('#new_comment_container')).toBeVisible();
    });

    describe('with invalid inputs', function() {
      it('displays the errors on the form', function() {
        $('#comment_content').val('');

        var fixtureForInvalidCommentResponse =
          'comments_controller-post-create-with-invalid-params-' +
          'generate-a-fixture.html';

        stubAjaxRequest(
          '/comments',
          fixtureForInvalidCommentResponse,
          433
        );

        $('#new_comment .actions input').click();
        expect($('#error_explanation_no_border')).toExist();
      });
    });

    var clickAndExpectPageRefresh = function(button) {
      spyOn(Turbolinks, 'visit');
      button.click();
      expect(Turbolinks.visit.calls.any()).toEqual(true);
    };

    describe('with valid inputs', function() {
      it('refreshes the page', function() {
        $('#comment_content').val('Here is a comment');
        stubAjaxRequest('/comments');
        clickAndExpectPageRefresh($('#new_comment .actions input'));
      });
    });

    describe('cancelling a new conversation', function() {
      it('it closes the form', function() {
        clickAndExpectPageRefresh($('.comment_cancel'));
      });
    });

  });

  function itBehavesLikeDropdownButton() {
    beforeEach(function() {
      this.arrowUp = this.dropdownButton.find('.icon_arrow_up');
      this.arrowDown = this.dropdownButton.find('.icon_arrow_down');
    });

    it('displays arrow down when closed', function() {
      expect(this.arrowUp).toBeHidden();
      expect(this.arrowDown).toBeVisible();
    });

    it('displays arrow up when opened', function() {
      this.dropdownButton.click();
      expect(this.arrowUp).toBeVisible();
      expect(this.arrowDown).toBeHidden();
      this.dropdownButton.click();
      expect(this.arrowUp).toBeHidden();
      expect(this.arrowDown).toBeVisible();
    });
  }
});
