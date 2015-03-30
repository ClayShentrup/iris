# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  key        :string           not null
#  enabled    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Features that can be flipped on and off via the Flip gem are declared here.
class Feature < ActiveRecord::Base
  extend Flip::Declarable

  strategy Flip::CookieStrategy
  strategy Flip::DatabaseStrategy
  strategy Flip::DeclarationStrategy
  default false

  # Declare your features here, e.g:
  #

  feature :pristine_example,
          default: false,
          description: 'How our code should look.'
end
