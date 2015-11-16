require 'test_helper'

class OfficeActionsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    @orlando = cities(:orlando)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'techs can get to the all offices page' do
    click_link 'Locations'
    click_link 'All Offices'
    assert page.has_css?('h3', text: /All Offices/)
  end

  test 'techs can get to the add offices page' do
    click_link 'Locations'
    click_link 'Add Offices'
    assert page.has_css?('h3', text: /Add Offices/)
  end

  test 'techs can add an office' do
    click_link 'Locations'
    click_link 'Add Offices'
    within('#new_office') do
      fill_in 'Office Name', with: 'Downtown'
      select 'Orlando, FL', from: 'City/State'
      choose 'office_active_1'
      click_button 'Add Office'
    end
    assert page.has_css?('.alert', text: /Office added!/)
    assert page.has_css?('table', text: /Downtown/)
  end

end
