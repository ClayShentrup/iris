require 'active_record_no_rails_helper'
require './app/models/authorized_domain'

RSpec.describe AuthorizedDomain, type: :model do
  subject { build_stubbed(described_class) }

  it { is_expected.to belong_to :account }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    context 'no need to access the database' do
      subject { build_stubbed(described_class) }
      it { is_expected.to be_valid }

      specify { is_expected.to validate_presence_of(:name) }
      specify { is_expected.to validate_presence_of(:account) }
    end
  end
end
