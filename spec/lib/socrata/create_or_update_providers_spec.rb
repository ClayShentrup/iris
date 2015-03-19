require 'socrata/create_or_update_providers'
require 'active_record_no_rails_helper'

RSpec.describe Socrata::CreateOrUpdateProviders, :vcr do
  let(:cassette) do
    'Socrata_CreateOrUpdateProviders/creates_or_updates_providers'
  end

  let(:block) { ->(_) {} }

  def call_with_vcr(&block)
    VCR.use_cassette(cassette) { described_class.call(&block) }
  end

  def call
    call_with_vcr(&block)
  end

  let(:new_existing_provider_attributes) do
    {
      'name' => 'SOUTHEAST ALABAMA MEDICAL CENTER',
      'zip_code' => '36301',
      'socrata_provider_id' => '010001',
      'state' => 'AL',
      'hospital_type' => 'Acute Care Hospitals',
      'city' => 'DOTHAN',
    }
  end

  def relevant_attributes(provider)
    provider.attributes.slice(*new_existing_provider_attributes.keys)
  end

  it 'returns the number of provider records processed' do
    expect(call).to be 3
  end

  describe 'with existing provider(s)' do
    let!(:existing_provider) { create(Provider, socrata_provider_id: '010001') }

    before { call }

    it 'updates existing providers' do
      expect(existing_provider.reload.attributes)
        .to include new_existing_provider_attributes
    end
  end

  context 'call can execute first' do
    before { call }

    let(:second_provider_attributes) do
      {
        'name' => 'MARSHALL MEDICAL CENTER SOUTH',
        'zip_code' => '35957',
        'socrata_provider_id' => '010005',
        'state' => 'AL',
        'hospital_type' => 'Acute Care Hospitals',
        'city' => 'BOAZ',
      }
    end
    let(:third_provider_attributes) do
      {
        'name' => 'ELIZA COFFEE MEMORIAL HOSPITAL',
        'zip_code' => '35631',
        'socrata_provider_id' => '010006',
        'state' => 'AL',
        'hospital_type' => 'Acute Care Hospitals',
        'city' => 'FLORENCE',
      }
    end

    it 'creates new providers' do
      saved_provider_attributes = Provider.all.map do |provider|
        relevant_attributes(provider)
      end

      expect(saved_provider_attributes).to include(
        second_provider_attributes,
        third_provider_attributes,
      )
    end

    describe 'block yield order' do
      let(:block) do
        lambda do |_|
          processed_provider_attributes << relevant_attributes(Provider.last)
        end
      end
      let(:processed_provider_attributes) { [] }

      it 'is yields to our block AS it processes results, not after' do
        expect(processed_provider_attributes).to eq [
          new_existing_provider_attributes,
          second_provider_attributes,
          third_provider_attributes,
        ]
      end
    end
  end

  it 'yields 0 based indexes' do
    expect { |block| call_with_vcr(&block) }
      .to yield_successive_args(0, 1, 2)
  end
end
