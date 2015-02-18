# == Schema Information
#
# Table name: pristine_examples
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'active_record_no_rails_helper'
require './app/models/pristine_example'

RSpec.describe PristineExample do
  describe 'columns' do
    specify do
      is_expected.to have_db_column(:name).of_type(:string)
        .with_options(null: false)
    end
    specify do
      is_expected.to have_db_column(:description).of_type(:text)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
