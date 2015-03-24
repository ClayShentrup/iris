require 'public_suffix'

# Ensure domain names added by an adminstrator are valid
# Checks for a valid suffix, as determined by the public_suffix gem:
# https://github.com/weppos/publicsuffix-ruby
class DomainNameValidator < ActiveModel::EachValidator
  DOMAIN_NAME_REGEX = /[\w-]+([.][\w-]+)+/
  ERROR_MESSAGE = 'Not a valid domain name'

  def validate_each(record, attribute, value)
    @record = record
    @attribute = attribute
    @value = value.to_s

    validate_domain_name
  end

  private

  def validate_domain_name
    add_error unless valid_suffix? and valid_format?
  end

  def add_error
    @record.errors[@attribute] << ERROR_MESSAGE
  end

  def valid_suffix?
    PublicSuffix.valid?(@value)
  end

  def valid_format?
    DOMAIN_NAME_REGEX.match(@value).nil? ? false : true
  end
end
