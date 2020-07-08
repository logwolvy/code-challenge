# frozen_string_literal: true

class Company < ApplicationRecord
  has_rich_text :description

  # Validations
  # TODO: combine both in custom validator
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'must be valid'
  }, allow_blank: true

  validates :email, format: {
    with: /\b.+@getmainstreet\.com\z/,
    message: 'must have a getmainstreet.com domain'
  }, allow_blank: true

  # Callbacks
  before_save :populate_city_and_state, if: proc { |company| company.zip_code.present? }

  private

  def populate_city_and_state
    decoded_zipcode = ZipCodes.identify(zip_code)
    self.city = decoded_zipcode[:city]
    self.state = decoded_zipcode[:state_code]
  end
end
