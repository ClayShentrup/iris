// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var searchEndpoint = '/provider_search_results/?term=';
  var oneProviderFixture =
    'provider_search_results_controller-index-return-one-provider.html';
  var twoProvidersFixture =
    'provider_search_results_controller-index-return-two-providers.html';

  var jQueryAutocompleteDelay = 300;

  var providerItems;
  var providerButton;
  var searchInput;
  var compareDropdown;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-public-data'
    );
    new Iris.Views['public_charts-show']({el: '#body'});

    searchInput = $('.dropdown_items.provider .search_box input');
    providerItems = $('.dropdown_items.provider');
    providerButton = $('.dropdown_button.provider');
  });

  it('shows compare options for default provider', function() {
    var compareDropdown = $('.dropdown_items.compare');
    var providerCityAndState = compareDropdown.find('ul li:first');
    var providerState = compareDropdown.find('ul li:nth-child(2)');
    var providerNation = compareDropdown.find('ul li:last');

    expect(providerCityAndState).toContainText('SAN FRANCISCO, CA');
    expect(providerCityAndState).toContainText('0 Providers');
    expect(providerState).toContainText('CA');
    expect(providerState).toContainText('0 Providers');
    expect(providerNation).toContainText('Nation-wide');
    expect(providerNation).toContainText('0 Providers');
  });

  describe('typing into the search input', function() {
    beforeEach(function() {
      expect(providerItems).toBeHidden();
      providerButton.click();
      expect(providerItems).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(providerItems).toContainText('UCSF Mission Bay');
      expect(providerItems).toContainText('UCSF Parnassus');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(providerItems.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'UCSF%20Mission', oneProviderFixture);
      searchAutocomplete(searchInput, 'UCSF Mission');
      expect(providerItems.find('li')).toHaveLength(1);
      expect(providerItems).toContainText('UCSF Mission Bay');
      expect(providerItems).not.toContainText('UCSF Parnassus');
    });
  });

  describe('selecting a provider', function() {
    beforeEach(function() {
      var compareEndpoint = '/provider_search_results/';
      var compareFixture =
        'provider_search_results_controller-show-provider-to-compare-' +
        'has-hospital-system.html';

      providerButton.click();

      stubAjaxRequest(searchEndpoint + 'UCSF', oneProviderFixture);
      searchAutocomplete(searchInput, 'UCSF');

      var providerToSelect = $('#body li:contains(UCSF)').data();
      expect(providerToSelect.socrataProviderId).toBeDefined();
      expect(providerToSelect.providerName).toBeDefined();
      expect(providerToSelect.providerCityAndState).toBeDefined();

      var compareUrl = compareEndpoint + providerToSelect.socrataProviderId;
      stubAjaxRequest(compareUrl, compareFixture);
      providerItems.find('li').click();
    });

    it('refreshes the compare dropdown', function() {
      var compareDropdown = $('.dropdown_items.compare');
      var providerCityAndState = compareDropdown.find('ul li:first');
      var providerState = compareDropdown.find('ul li:nth-child(2)');
      var providerSystem = compareDropdown.find('ul li:nth-child(3)');
      var providerNation = compareDropdown.find('ul li:last');

      expect(providerCityAndState).toContainText('SAN FRANCISCO, CA');
      expect(providerCityAndState).toContainText('2 Providers');
      expect(providerState).toContainText('CA');
      expect(providerState).toContainText('3 Providers');
      expect(providerSystem).toContainText('Test System');
      expect(providerSystem).toContainText('2 Providers');
      expect(providerNation).toContainText('Nation-wide');
      expect(providerNation).toContainText('4 Providers');
    });

    it('updates hospital name and city in dropdown buttons', function() {
      var providerName = $('.dropdown_button.provider .provider_name');
      var providerCityAndState = $('.dropdown_button.compare .compare_name');

      expect(providerName).toContainText('UCSF Mission Bay');
      expect(providerCityAndState).toContainText('SAN FRANCISCO, CA');
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
      compareDropdown.find('li').eq(2).click();

      expect(compareName).toContainText('Nation-wide');
      expect($('.dropdown_items.compare')).toBeHidden();
    });
  });

  describe('close button', function() {
    it ('clears the field and the previous search results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);
      searchAutocomplete(searchInput, 'UCSF');
      providerButton.click();

      $('.search_box .icon_close').click();

      expect($('.dropdown_items')).toBeHidden();
      providerButton.click();

      expect(searchInput).toBeEmpty();
      expect(providerItems.find('ul')).toBeEmpty();
    });
  });

  describe('provider dropdown button', function() {
    beforeEach(function() {
      this.dropdownButton = providerButton;
    });

    itBehavesLikeDropdownButton();
  });

  describe('compare dropdown button', function() {
    beforeEach(function() {
      this.dropdownButton = $('.dropdown_button.compare');
    });

    itBehavesLikeDropdownButton();
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
