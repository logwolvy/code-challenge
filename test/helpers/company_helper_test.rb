# frozen_string_literal: true

require 'test_helper'

class CompanyHelperTest < ActionView::TestCase
  test 'city_state_with_defaults' do
    company = companies(:wolf_painting)
    # Update to fire callback
    company.update!(zip_code: '37201')

    assert_equal 'Nashville, TN', city_state_with_defaults(company)
  end
end
