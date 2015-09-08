require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @c = cities(:orlando)
  end

  test 'should not save without a name' do
    assert_not_blank(@c, :name)
  end

  test 'should strip whitespace in name before save' do
    should_strip_whitespace(@c, :name)
  end

  test 'should not save without a state_id' do
    assert_not_blank(@c, :state_id)
  end

  test 'should not allow save of duplicate city/states' do
    city2 = City.new(name: 'Orlando', state_id: states(:florida).id)
    assert_not city2.save, 'Allowed save of duplicate city/state'
  end

  test 'should be able to save same city with different state' do
    city2 = City.new(name: 'Orlando', state_id: states(:texas).id)
    assert city2.save
  end

  test 'city_state_abbr' do
    assert_equal 'Orlando, FL', @c.city_state_abbr
  end

end
