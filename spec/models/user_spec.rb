# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  is_dabo_admin          :boolean          default(FALSE), not null
#  account_id             :integer
#  password_changed_at    :datetime
#  unique_session_id      :string(20)
#  first_name             :string           not null
#  last_name              :string           not null
#  selected_provider_id   :integer
#  selected_context       :string
#

require 'active_record_no_rails_helper'
require './app/models/user'

RSpec.describe User do
  subject { build_stubbed(described_class) }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:is_dabo_admin).of_type(:boolean)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:unique_session_id).of_type(:string)
        .with_options(limit: 20)
    end
    it do
      is_expected.to have_db_column(:first_name).of_type(:string)
        .with_options(null: false)
      is_expected.to have_db_column(:last_name).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    it do
      is_expected.to be_valid
    end

    describe 'associations' do
      before { subject.skip_association_presence_validations = false }
      it { is_expected.to validate_presence_of(:account) }
    end

    context 'requires saved model' do
      subject { create(described_class) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value(false).for(:is_dabo_admin) }
    it { is_expected.not_to allow_value(nil).for(:is_dabo_admin) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    describe 'password must be strong' do
      subject { build_stubbed(:user, password: password) }
      let(:password) { 'abcdefghijkl!2' }

      context 'with fewer than 15 chars and fewer than 3 special chars' do
        specify do
          expect(subject).not_to be_valid
          expect(subject.errors[:password].length).to be 1
        end
      end

      context 'strong because of having at least three special characters' do
        before { password[0] = '!' }
        it { is_expected.to be_valid }
      end

      context 'strong because of having at least 15 characters' do
        before { password << 'a' }
        it { is_expected.to be_valid }
      end
    end

    describe 'Devise password archivable' do
      subject { create(described_class, password: first_password) }

      let(:first_password) { 'pushvisitbuilttail' }
      let(:second_password) { 'shineaccordingtreehit' }

      it 'does not allow an already used password' do
        expect(subject).to be_valid
        subject.password = second_password
        expect(subject).to be_valid
        expect { subject.update_attributes(password: first_password) }
          .to change { subject.errors[:password].length }
          .from(0).to(1)
      end
    end
  end

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to(:selected_provider).class_name('Provider') }

  describe 'delegations' do
    specify do
      is_expected.to delegate_method(:purchased_metric_modules)
        .to(:account)
    end
    specify do
      is_expected.to delegate_method(:default_provider).to(:account)
    end
  end

  describe '#selected_provider' do
    context 'a selected_provider has been set' do
      let(:user) { build_stubbed(User, selected_provider: selected_provider) }
      let(:selected_provider) { build_stubbed(:provider) }

      it 'gives the selected provider' do
        expect(user.selected_provider).to eq(selected_provider)
      end
    end

    context 'a selected_provider has not been set' do
      let(:account) { build_stubbed(Account, :with_associations) }
      let(:user) { build_stubbed(User, account: account) }
      let(:default_provider) { user.default_provider }

      it 'gives the default provider for the account' do
        expect(user.selected_provider).to eq(default_provider)
      end
    end
  end

  describe '#selected_context' do
    context 'a selected_context has been set' do
      let(:user) { build_stubbed(User, selected_context: selected_context) }
      let(:selected_context) { 'system' }

      it 'gives the selected context' do
        expect(user.selected_context).to eq(selected_context)
      end
    end

    context 'a selected_context has not been set' do
      let(:user) { build_stubbed(User) }
      let(:default_context) { 'city' }

      it 'gives the default provider for the account' do
        expect(user.selected_context).to eq(default_context)
      end
    end
  end
end
