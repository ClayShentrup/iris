# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :text             not null
#  author_id       :integer
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require './app/models/conversation'
require './app/models/user'
require './app/models/agreement'

# A user comment associated with a conversation
class Comment < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :author, class_name: 'User'
  has_many :agreements, as: :item, dependent: :destroy

  validates :content, presence: true

  validates :author, presence: true,
                     unless: :skip_association_presence_validations

  validates :conversation, presence: true,
                           unless: :skip_association_presence_validations

  attr_accessor :skip_association_presence_validations

  delegate :measure_id, to: :conversation, prefix: true
end
