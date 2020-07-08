module CompanyHelper
  def city_state_with_defaults(company)
    "#{company.city || 'City'}, #{company.state || 'State'}"
  end
end
