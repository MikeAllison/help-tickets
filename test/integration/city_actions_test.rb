require 'test_helper'

class CityActionsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
  end

  test 'techs can get to the all cities page' do
    integration_login(@active_tech)
    click_link 'Locations'
    click_link 'All Cities'
    #assert page.has_text?(/All Cities/)
    #assert assigns(:cities)
  end

  # test 'techs can add a city' do
  #   integration_login(@active_tech)
  #   click_link 'Locations'
  #   click_link 'All Cities'
  # end

end
