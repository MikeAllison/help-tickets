require 'test_helper'

class NontechActionsTest < ActionDispatch::IntegrationTest
  def setup
    @active_nontech = employees(:active_nontech)
    integration_login(@active_nontech)
  end

  def teardown
    logout!
  end

  test 'nontechs can change their first name' do
    click_link 'My Account'
    within('.edit_employee') do
      fill_in 'First Name', with: 'Mike'
      click_button 'Update Employee'
    end
    assert page.has_css?('.alert', text: /Employee profile updated!/)
  end

  test 'nontechs can change their last name' do
    click_link 'My Account'
    within('.edit_employee') do
      fill_in 'Last Name', with: 'Allison'
      click_button 'Update Employee'
    end
    assert page.has_css?('.alert', text: /Employee profile updated!/)
  end

  test 'nontechs can change their office' do
    click_link 'My Account'
    within('.edit_employee') do
      select "Fisherman's Wharf - San Francisco, CA", from: 'Office'
      click_button 'Update Employee'
    end
    assert page.has_css?('.alert', text: /Employee profile updated!/)
  end

  test 'nontechs can change their password' do
    click_link 'My Account'
    within('.edit_employee') do
      fill_in 'Password', with: 'Pass1234'
      fill_in 'Password Confirmation', with: 'Pass1234'
      click_button 'Update Employee'
    end
    assert page.has_css?('.alert', text: /Employee profile updated!/)
  end

  test 'password and password confirmation need to match' do
    click_link 'My Account'
    within('.edit_employee') do
      fill_in 'Password', with: 'Pass1234'
      fill_in 'Password Confirmation', with: 'NotTheSame'
      click_button 'Update Employee'
    end
    assert page.has_css?('.validation-errors', text: /Passwords must match!/)
  end
end
