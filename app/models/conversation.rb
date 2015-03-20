# == Schema Information
#
# Table name: conversations
#
#  id                :integer          not null, primary key
#  provider_id       :integer
#  author_id         :integer
#  node_id_component :string           not null
#  title             :string           not null
#  description       :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require './app/models/provider'
require './app/models/user'

# An entity that represents the beginning of a conversation for a given provider
# and node_id
class Conversation < ActiveRecord::Base
  belongs_to :provider
  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :description, presence: true
  validates :node_id_component, presence: true

  validates :author, presence: true, unless: :skip_association_validations
  validates :provider, presence: true, unless: :skip_association_validations

  delegate :account, to: :author, prefix: true

  attr_accessor :skip_association_validations

  scope :for_chart, (lambda do |provider_id, node_id_component, current_user|
    joins('JOIN users ON conversations.author_id = users.id')
      .where(
        provider_id: provider_id,
        node_id_component: node_id_component,
      )
      .merge(current_user.account.users)
      .order(created_at: :desc)
  end)
end
