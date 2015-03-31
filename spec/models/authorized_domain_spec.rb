# == Schema Information
#
# Table name: authorized_domains
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'active_record_no_rails_helper'
require './app/models/authorized_domain'

RSpec.describe AuthorizedDomain do
  subject { build_stubbed(described_class) }

  it { is_expected.to belong_to :account }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    subject { build_stubbed(described_class) }
    it { is_expected.to be_valid }

    specify { is_expected.to validate_presence_of(:name) }

    context 'blank domain name' do
      subject { build_stubbed(described_class, name: '') }
      it { is_expected.not_to be_valid }
    end

    context 'invalid domain name' do
      invalid_names = ['googlecom', '$$$.com', '@.@', 'dabo!.edu']
      invalid_names.each do |invalid_name|
        subject { build_stubbed(described_class, name: invalid_name) }
        it { is_expected.not_to be_valid }
      end
    end

    context 'valid domain name' do
      valid_names = ['bbc.co.uk', 'mayo-health.com', 'dabo.edu']
      valid_names.each do |valid_name|
        subject { build_stubbed(described_class, name: valid_name) }
        it { is_expected.to be_valid }
      end
    end

    context 'no need to access the database' do
      subject { build_stubbed(described_class, :with_associations) }

      before { subject.skip_association_presence_validations = false }

      it { is_expected.to be_valid }

      specify { is_expected.to validate_presence_of(:name) }
      specify { is_expected.to validate_presence_of(:account) }
    end
  end
end
