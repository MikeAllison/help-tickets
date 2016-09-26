require 'test_helper'

class TopicActionsTest < ActionDispatch::IntegrationTest
  def setup
    @active_tech = employees(:active_tech)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'techs can get to the all topics page' do
    click_link 'Topics'
    click_link 'All Topics'
    assert page.has_css?('h3', text: /All Topics/)
  end

  test 'techs can get to the add topics page' do
    click_link 'Topics'
    click_link 'Add Topics'
    assert page.has_css?('h3', text: /Add Topics/)
  end

  test 'techs can add a topic' do
    click_link 'Topics'
    click_link 'Add Topics'
    within('#new_topic') do
      fill_in 'Topic Name', with: 'Excel'
      choose 'topic_active_1'
      click_button 'Add Topic'
    end
    assert page.has_css?('.alert', text: /Topic added!/)
    assert page.has_css?('table', text: /Excel/)
  end
end
