require 'socrata/simple_soda_client'

RSpec.describe Socrata::SimpleSodaClient, :vcr do
  subject do
    described_class.new(
      dataset_id: dataset_id,
      required_columns: required_columns,
      row_filter: row_filter,
    )
  end
  let(:page) { 1 }
  let(:dataset_id) { 'xubh-q36u' }
  let(:required_columns) do
    %w[
      provider_id
      hospital_name
    ]
  end
  let(:row_filter) { nil }

  def response
    subject.get(page: page)
  end

  before do
    stub_const("#{described_class.name}::PAGE_SIZE", 3)
  end

  describe '#get' do
    it 'gets records for the specified page' do
      expect(response).to eq [
        {
          'hospital_name' => 'MIZELL MEMORIAL HOSPITAL',
          'provider_id' => '010007',
        },
        {
          'hospital_name' => 'CRENSHAW COMMUNITY HOSPITAL',
          'provider_id' => '010008',
        },
        {
          'hospital_name' => "ST VINCENT'S EAST",
          'provider_id' => '010011',
        },
      ]
    end

    context 'filtered', :vcr do
      let(:row_filter) do
        {
          column_name: :provider_id,
          value: '010001',
        }
      end

      it 'only returns matching rows' do
        expect(response).to eq [
          {
            'hospital_name' => 'SOUTHEAST ALABAMA MEDICAL CENTER',
            'provider_id' => '010001',
          },
        ]
      end
    end
  end

  describe '#possible_next_page?' do
    context 'when no results have been gotten yet' do
      specify { expect(subject.possible_next_page?).to be true }
    end

    context 'results have been gotten' do
      before do
        response
      end

      context 'with a full page of results' do
        specify { expect(subject.possible_next_page?).to be true }
      end

      context 'with less than a full page of results' do
        let(:page) { 2 }
        specify { expect(subject.possible_next_page?).to be false }
      end
    end
  end
end
