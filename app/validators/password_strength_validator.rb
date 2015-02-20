# Ensure passwords are HIPPA and 21 CFR part 11 compliant
# Passwords must be at least 8 characters long.
# Passwords with fewer than 15 characters must contain at least 3 uppercase,
# numeric, or special characters.
class PasswordStrengthValidator < ActiveModel::EachValidator
  MIN_SPECIAL_CHARACTER_COUNT = 3
  LONG_PASSWORD_MIN_LENGTH = 15
  SPECIAL_CHARACTER_REGEX = /[A-Z]|[0-9]|(\W|_)/
  ERROR_MESSAGE = 'containing less than 15 characters needs to have a ' \
                  'minimum of 3 uppercase, numeric, or special characters'

  def validate_each(record, attribute, value)
    @record = record
    @attribute = attribute
    @value = value.to_s

    validate_password_requirements
  end

  private

  def validate_password_requirements
    @record.errors[@attribute] << ERROR_MESSAGE unless strong_password?
  end

  def strong_password?
    contains_min_special_characters? || long_password?
  end

  def contains_min_special_characters?
    @value.scan(SPECIAL_CHARACTER_REGEX).length >= MIN_SPECIAL_CHARACTER_COUNT
  end

  def long_password?
    @value.length >= LONG_PASSWORD_MIN_LENGTH
  end
end
