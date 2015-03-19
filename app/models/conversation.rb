# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  provider_id :integer
#  user_id     :integer
#  node_id     :string
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require './app/models/provider'
require './app/models/user'

# An entity that represents the beginning of a conversation for a given provider
# and node_id
class Conversation < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :node_component_id, presence: true

  validates :user, presence: true, unless: :skip_association_validations
  validates :provider, presence: true, unless: :skip_association_validations

  delegate :account, to: :user, prefix: true

  attr_accessor :skip_association_validations
end
