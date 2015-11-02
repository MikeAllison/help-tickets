require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @active_nontech = employees(:active_nontech)
    @active_tech = employees(:active_tech)
    @inactive_nontech = employees(:inactive_nontech)
    @inactive_tech = employees(:inactive_tech)
  end

  test 'active non-techs log in and out' do
    integration_login(@active_nontech)
    click_link('Log Out')
  end

  test 'active non-techs cannot log in with a bad password' do
    integration_login(@active_nontech, 'badpassword')
    assert page.has_css?('.alert', /Invalid credentials!/)
  end

  test 'inactive non-techs cannot log in' do
    integration_login(@inactive_nontech)
    assert page.has_css?('.alert', /Your account is currently inactive!/)
  end

  test 'active techs log in and out' do
    integration_login(@active_tech)
    click_link('Log Out')
  end

  test 'active techs cannot log in with a bad password' do
    integration_login(@active_tech, 'badpassword')
    assert page.has_css?('.alert', /Invalid credentials!/)
  end

  test 'inactive techs cannot log in' do
    integration_login(@inactive_tech)
    assert page.has_css?('.alert', /Your account is currently inactive!/)
  end

  test 'non-techs are redirected correctly after login' do
    integration_login(@active_nontech)

    assert page.has_css?('.alert', text: /You are logged in!/)
    assert page.has_text?(/My Tickets/)
    assert page.has_text?(/Hello, #{@active_nontech.fname}!/)

    assert page.has_link?('My Tickets', href: /tickets\/my/)
    assert page.has_link?('My Account', href: /employees\/#{@active_nontech.username}\/edit/)
    assert page.has_link?('Create Ticket', href: /tickets\/new/)

    assert page.has_link?('Log Out', href: /logout/)

    click_link('Log Out')
  end

  test 'active techs are redirected correctly after login' do
    integration_login(@active_tech)

    assert page.has_css?('.alert', text: /You are logged in!/)
    assert page.has_text?(/Tickets Assigned To Me/)
    assert page.has_text?(/Hello, #{@active_tech.fname}!/)

    assert page.has_link?('Tickets', href: /#/)
    click_link('Tickets')
    assert page.has_link?('Create a Ticket', href: /tickets\/new/)
    assert page.has_link?('My Tickets', href: /tickets\/my/)
    assert page.has_link?('Assigned To Me', href: /tickets\/assigned_to_me/)
    assert page.has_link?('Open', href: /tickets\/open/)
    assert page.has_link?('All', href: /tickets\/all/)
    assert page.has_link?('Unassigned', href: /tickets\/unassigned/)
    assert page.has_link?('Work In Progress', href: /tickets\/work_in_progress/)
    assert page.has_link?('On Hold', href: /tickets\/on_hold/)
    assert page.has_link?('Closed', href: /tickets\/closed/)

    assert page.has_link?('Employees', href: /#/)
    click_link('Employees')
    assert page.has_link?('Add Employees', href: /employees\/new/)
    assert page.has_link?('All', href: /employees\/all/)
    assert page.has_link?('Active', href: /employees\/active/)
    assert page.has_link?('Inactive', href: /employees\/inactive/)
    assert page.has_link?('Technician', href: /employees\/technician/)

    assert page.has_link?('Topics', href: /#/)
    click_link('Topics')
    assert page.has_link?('Add Topics', href: /topics\/new/)
    assert page.has_link?('All Topics', href: /topics/)

    assert page.has_link?('Locations', href: /#/)
    click_link('Locations')
    assert page.has_link?('Add Offices', href: /offices\/new/)
    assert page.has_link?('All Offices', href: /offices/)
    assert page.has_link?('Add Cities', href: /cities\/new/)
    assert page.has_link?('All Cities', href: /cities/)

    assert page.has_link?('Log Out')

    click_link('Log Out')
  end

end
