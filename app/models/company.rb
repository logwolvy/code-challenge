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
end
