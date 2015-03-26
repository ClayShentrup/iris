require 'feature_spec_helper'

RSpec.feature 'User selected hospital' do
  let(:user) { create(User, :authenticatable, :confirmed, :with_associations) }
  let!(:provider) { create :provider, name: provider_name }
  let!(:another_provider) { create :provider }
  let(:provider_name) { 'Children\'s Hospital' }
  let(:other_provider_name) { another_provider.name }
  let(:url) do
    %w[
      /
      metrics
      public-data
      hospital-acquired-conditions
    ].join('/')
  end
  let(:new_url) do
    %w[
      /
      metrics
      public-data
      readmissions-reduction-program
    ].join('/')
  end
  let(:selector) { '.dropdown_items.provider li a' }
  let(:field_id) { 'provider_search' }
  let(:dropdown_button) { '.dropdown_button.provider' }

  def search_and_select_provider
    fill_in field_id, with: provider_name
    focus_and_type_in_search_field
    expect(page).to have_selector selector
    find(selector).click
    check_for_content
  end

  def focus_and_type_in_search_field
    page.execute_script %{ $('##{field_id}').trigger('focus') }
    page.execute_script %{ $('##{field_id}').trigger('keydown') }
  end

  def check_for_content
    within dropdown_button do
      expect(page).not_to have_content other_provider_name
      expect(page).to have_content provider_name
    end
  end

  before do
    log_in user
    visit url
    find(dropdown_button).click
    search_and_select_provider
  end

  describe 'is persisted' do
    it 'when the user logs out and logs back in' do
      log_out
      log_in user
      visit url
      check_for_content
    end

    it 'when the user navigates to a different metric' do
      visit new_url
      check_for_content
    end
  end
end
