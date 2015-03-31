# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  provider_id :integer
#  author_id   :integer
#  measure_id  :string           not null
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require './app/models/provider'
require './app/models/user'
require './app/models/agreement'

# An entity that represents the beginning of a conversation for a given provider
# and node_id
class Conversation < ActiveRecord::Base
  belongs_to :provider
  belongs_to :author, class_name: 'User'
  has_many :agreements, as: :item, dependent: :destroy

  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :measure_id, presence: true

  validates :author, presence: true,
                     unless: :skip_association_presence_validations
  validates :provider, presence: true,
                       unless: :skip_association_presence_validations

  delegate :account, to: :author, prefix: true

  attr_accessor :skip_association_presence_validations

  scope :for_chart, (lambda do |measure_id, current_user|
    joins('JOIN users ON conversations.author_id = users.id')
      .where(
        provider_id: current_user.selected_provider,
        measure_id: measure_id,
      )
      .merge(current_user.account.users)
      .order(created_at: :desc)
  end)
end
