# frozen_string_literal: true

class Company < ApplicationRecord
  EMAIL_DOMAIN_PATTERN = /\b.+@getmainstreet\.com\z/.freeze
  has_rich_text :description

  # Validations
  validate :email_format, if: proc { |c| c.email.present? }

  # Callbacks
  before_save :populate_city_and_state, if: proc { |c| c.zip_code.present? }

  private

  def email_format
    return if URI::MailTo::EMAIL_REGEXP.match?(email) &&
              EMAIL_DOMAIN_PATTERN.match?(email)

    if URI::MailTo::EMAIL_REGEXP.match?(email)
      errors.add(:email, 'must have a getmainstreet.com domain')
    else
      errors.add(:email, 'must be valid')
    end
  end

  def populate_city_and_state
    decoded_zipcode = ZipCodes.identify(zip_code)
    self.city = decoded_zipcode[:city]
    self.state = decoded_zipcode[:state_code]
  end
end
