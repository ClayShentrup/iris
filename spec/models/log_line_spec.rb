require 'active_record_no_rails_helper'
require './app/models/log_line'

# == Schema Information
#
# Table name: log_lines
#
#  id                :integer          not null, primary key
#  heroku_request_id :string           not null
#  data              :text             not null
#  logged_at         :datetime         not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

RSpec.describe LogLine do
  describe '#data' do
    let(:subject) { FactoryGirl.create(:log_line, data: data) }
    let(:data) do
      {
        'foo' => 'one',
      }
    end

    it 'serializes data' do
      expect(subject.data).to eq data
    end
  end

  describe 'columns' do
    specify do
      should have_db_column(:heroku_request_id).of_type(:string).with_options(
        null: false,
      )
      should have_db_column(:data).of_type(:text).with_options(null: false)
      should have_db_column(:logged_at).of_type(:datetime).with_options(
        null: false,
      )
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:heroku_request_id) }
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:logged_at) }
  end
end
