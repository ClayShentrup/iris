// jshint nonew: false
'use strict';

describe('PublicChartsView', function() {
  var jQueryAutocompleteDelay = 300;
  var hospitalDropdown;
  var searchInput;
  var searchEndpoint = '/hospital_search_results/?term=';
  var oneHospitalFixture =
    'hospital_search_results_controller-index-return-one-hospital.html';
  var twoHospitalsFixture =
    'hospital_search_results_controller-index-return-two-hospitals.html';
  var compareDropdown;

  beforeEach(function() {
    loadFixture(
      'public_charts_controller-get-show-public-data'
    );
    new Iris.Views['public_charts-show']({el: '#body'});

    searchInput = $('.dropdown_items.hospital .search_box input');
    hospitalDropdown = $('.dropdown_items.hospital');
  });

  it('shows compare options for default hospital', function() {
    var compareDropdown = $('.dropdown_items.compare');
    var hospitalCityAndState = compareDropdown.find('ul li:first');
    var hospitalState = compareDropdown.find('ul li:nth-child(2)');
    var hospitalNation = compareDropdown.find('ul li:last');

    expect(hospitalCityAndState).toContainText('SAN FRANCISCO, CA');
    expect(hospitalCityAndState).toContainText('0 Hospitals');
    expect(hospitalState).toContainText('CA');
    expect(hospitalState).toContainText('0 Hospitals');
    expect(hospitalNation).toContainText('Nation-wide');
    expect(hospitalNation).toContainText('0 Hospitals');
  });

  describe('typing into the search input', function() {
    beforeEach(function() {
      expect(hospitalDropdown).toBeHidden();
      $('.dropdown_button.hospital').click();
      expect(hospitalDropdown).toBeVisible();
    });

    it('displays a list of matching results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(hospitalDropdown).toContainText('UCSF Mission Bay');
      expect(hospitalDropdown).toContainText('UCSF Parnassus');
    });

    it('clears out the previous results', function() {
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);

      searchAutocomplete(searchInput, 'UCSF');
      expect(hospitalDropdown.find('li')).toHaveLength(2);

      stubAjaxRequest(searchEndpoint + 'UCSF%20Mission', oneHospitalFixture);
      searchAutocomplete(searchInput, 'UCSF Mission');
      expect(hospitalDropdown.find('li')).toHaveLength(1);
      expect(hospitalDropdown).toContainText('UCSF Mission Bay');
      expect(hospitalDropdown).not.toContainText('UCSF Parnassus');
    });
  });

  describe('selecting a hospital', function() {
    beforeEach(function() {
      var compareEndpoint = '/hospital_search_results/';
      var compareFixture =
        'hospital_search_results_controller-show-hospital-to-compare-' +
        'has-hospital-system.html';

      stubAjaxRequest(searchEndpoint + 'UCSF', oneHospitalFixture);
      searchAutocomplete(searchInput, 'UCSF');

      var hospitalToSelect = $('#body li:contains(UCSF)').data();
      var hospitalId = hospitalToSelect.hospitalId;

      stubAjaxRequest(compareEndpoint + hospitalId, compareFixture);
      hospitalDropdown.find('li').click();
    });

    it('refreshes the compare dropdown', function() {
      var compareDropdown = $('.dropdown_items.compare');
      var hospitalCityAndState = compareDropdown.find('ul li:first');
      var hospitalState = compareDropdown.find('ul li:nth-child(2)');
      var hospitalSystem = compareDropdown.find('ul li:nth-child(3)');
      var hospitalNation = compareDropdown.find('ul li:last');

      expect(hospitalCityAndState).toContainText('SAN FRANCISCO, CA');
      expect(hospitalCityAndState).toContainText('2 Hospitals');
      expect(hospitalState).toContainText('CA');
      expect(hospitalState).toContainText('3 Hospitals');
      expect(hospitalSystem).toContainText('Test System');
      expect(hospitalSystem).toContainText('2 Hospitals');
      expect(hospitalNation).toContainText('Nation-wide');
      expect(hospitalNation).toContainText('4 Hospitals');
    });

    it('updates hospital name and city in dropdown buttons', function() {
      var hospitalName = $('.dropdown_button.hospital .hospital_name');
      var hospitalCityAndState = $('.dropdown_button.compare .compare_name');

      expect(hospitalName).toContainText('UCSF Mission Bay');
      expect(hospitalCityAndState).toContainText('SAN FRANCISCO, CA');
    });
  });

  describe('selecting a compare option', function() {
    beforeEach(function() {
      var compareFixture =
        'hospital_search_results_controller-show-hospital-to-compare-' +
        'has-hospital-system.html';

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
      stubAjaxRequest(searchEndpoint + 'UCSF', twoHospitalsFixture);
      searchAutocomplete(searchInput, 'UCSF');
      $('.dropdown_button.hospital').click();

      $('.search_box .icon_close').click();

      expect($('.dropdown_items')).toBeHidden();
      $('.dropdown_button.hospital').click();

      expect(searchInput).toBeEmpty();
      expect(hospitalDropdown.find('ul')).toBeEmpty();
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
