# == Schema Information
#
# Table name: log_lines
#
#  id                :integer          not null, primary key
#  heroku_request_id :string
#  data              :text
#  logged_at         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'active_record_spec_helper'
require './app/models/log_line'

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
end
