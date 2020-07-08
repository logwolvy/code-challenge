# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'should not validate email if blank' do
    company = Company.new(company_attributes.tap { |rec| rec[:email] = nil })
    assert company.valid?
  end

  test 'should validate email domain is getmainstreet.com' do
    company = Company.new(company_attributes)
    assert company.invalid?
    assert_equal ['must have a getmainstreet.com domain'], company.errors[:email]
  end

  test 'should populate city, state details from pincode on save or update' do
    company = Company.create!(company_attributes(:wolf_painting))
    assert_equal 'Ventura', company.city
    assert_equal 'CA', company.state
  end

  private

  def company_attributes(key = :hometown_painting)
    companies(key).attributes.except('id')
  end
end
