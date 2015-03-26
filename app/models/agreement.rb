# == Schema Information
#
# Table name: agreements
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  item_type  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require './app/models/conversation'
require './app/models/comment'
require './app/models/user'

# A user agreement associated with a conversation or comment
class Agreement < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  belongs_to :user

  validates :user, presence: true, unless: :skip_association_validations
  validates :item, presence: true, unless: :skip_association_validations

  attr_accessor :skip_association_validations
end
