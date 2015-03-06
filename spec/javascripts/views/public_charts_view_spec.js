// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var jQueryAutocompleteDelay = 300;
  var providerDropdown;
  var searchInput;
  var searchEndpoint = '/provider_search_results/?term=';
  var oneProviderFixture =
    'provider_search_results_controller-index-return-one-provider.html';
  var twoProvidersFixture =
    'provider_search_results_controller-index-return-two-providers.html';
  var compareDropdown;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-public-data'
    );
    new Iris.Views['public_charts-show']({el: '#body'});

    searchInput = $('.dropdown_items.hospital .search_box input');
    providerDropdown = $('.dropdown_items.hospital');
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
      expect(providerDropdown).toBeHidden();
      $('.dropdown_button.hospital').click();
      expect(providerDropdown).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(providerDropdown).toContainText('UCSF Mission Bay');
      expect(providerDropdown).toContainText('UCSF Parnassus');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoProvidersFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(providerDropdown.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'UCSF%20Mission', oneProviderFixture);
      searchAutocomplete(searchInput, 'UCSF Mission');
      expect(providerDropdown.find('li')).toHaveLength(1);
      expect(providerDropdown).toContainText('UCSF Mission Bay');
      expect(providerDropdown).not.toContainText('UCSF Parnassus');
    });
  });

  describe('selecting a provider', function() {
    beforeEach(function() {
      var compareEndpoint = '/provider_search_results/';
      var compareFixture =
        'provider_search_results_controller-show-provider-to-compare-' +
        'has-hospital-system.html';

      stubAjaxRequest(searchEndpoint + 'UCSF', oneProviderFixture);
      searchAutocomplete(searchInput, 'UCSF');

      var hospitalToSelect = $('#body li:contains(UCSF)').data();
      var hospitalId = hospitalToSelect.hospitalId;

      stubAjaxRequest(compareEndpoint + hospitalId, compareFixture);
      providerDropdown.find('li').click();
    });

    it('refreshes the compare dropdown', function() {
      var compareDropdown = $('.dropdown_items.compare');
      var hospitalCityAndState = compareDropdown.find('ul li:first');
      var hospitalState = compareDropdown.find('ul li:nth-child(2)');
      var hospitalSystem = compareDropdown.find('ul li:nth-child(3)');
      var hospitalNation = compareDropdown.find('ul li:last');

      expect(hospitalCityAndState).toContainText('SAN FRANCISCO, CA');
      expect(hospitalCityAndState).toContainText('2 Providers');
      expect(hospitalState).toContainText('CA');
      expect(hospitalState).toContainText('3 Providers');
      expect(hospitalSystem).toContainText('Test System');
      expect(hospitalSystem).toContainText('2 Providers');
      expect(hospitalNation).toContainText('Nation-wide');
      expect(hospitalNation).toContainText('4 Providers');
    });

    it('updates hospital name and city in dropdown buttons', function() {
      var hospitalName = $('.dropdown_button.hospital .hospital_name');
      var hospitalCityAndState = $('.dropdown_button.compare .compare_name');

      expect(hospitalName).toContainText('SAN FRANCISCO GENERAL HOSPITAL');
      expect(hospitalCityAndState).toContainText('SAN FRANCISCO, CA');
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
      $('.dropdown_button.hospital').click();

      $('.search_box .icon_close').click();

      expect($('.dropdown_items')).toBeHidden();
      $('.dropdown_button.hospital').click();

      expect(searchInput).toBeEmpty();
      expect(providerDropdown.find('ul')).toBeEmpty();
    });
  });

  describe('hospital dropdown button', function() {
    beforeEach(function() {
      this.dropdownButton = $('.dropdown_button.hospital');
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
