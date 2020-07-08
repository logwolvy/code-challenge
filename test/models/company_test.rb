# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'should not validate email if blank' do
    company = Company.new(
      companies(:hometown_painting).attributes.tap { |rec| rec[:email] = nil }
    )
    assert company.valid?
  end

  test 'should validate email domain is getmainstreet.com' do
    company = Company.new(companies(:hometown_painting).attributes)
    assert company.invalid?
    assert_equal ['must have a getmainstreet.com domain'], company.errors[:email]
  end

  test 'should populate city, state details from pincode on save or update' do
    company = Company.create!(companies(:wolf_painting).attributes.except('id'))
    assert_equal 'Ventura', company.city
    assert_equal 'CA', company.state
  end
end
