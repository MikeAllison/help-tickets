require 'test_helper'

class CityActionsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'techs can get to the all cities page' do
    click_link 'Locations'
    click_link 'All Cities'
    assert page.has_css?('h3', text: /All Cities/)
  end

  test 'techs can get to the add cities page' do
    click_link 'Locations'
    click_link 'Add Cities'
    assert page.has_css?('h3', text: /Add Cities/)
  end

  test 'techs can add a city' do
    click_link 'Locations'
    click_link 'Add Cities'
    within('#new_city') do
      fill_in 'City Name', with: 'Tampa'
      select 'Florida', from: 'State'
      click_button 'Add City'
    end
    assert page.has_css?('.alert', text: /City added!/)
    assert page.has_css?('table', text: /Tampa/)
  end

end
