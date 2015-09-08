require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test 'should not save without a name' do
    city = cities(:orlando)
    city.name = ''
    assert_not city.save
  end

  test 'should not have duplicate city/states' do
    city1 = cities(:orlando)
    city2 = City.new(name: 'Orlando', state_id: states(:florida).id)
    assert_not city2.save
  end

  test 'should be able to save same city with different state' do
    city1 = cities(:orlando)
    city2 = City.new(name: 'Orlando', state_id: states(:texas).id)
    assert city2.save
  end

  test 'should not save without a state_id' do
    city = cities(:orlando)
    city.state_id = nil
    assert_not city.save
  end

end
