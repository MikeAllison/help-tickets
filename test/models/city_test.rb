require 'test_helper'

class CityTest < ActiveSupport::TestCase

  State.create([
    { name: 'Florida', abbreviation: 'FL' },
    { name: 'Massachusetts', abbreviation: 'MA' }
  ])

  city = City.new(name: 'Orlando', state_id: 1)

  test 'should not save without a name' do
    city.name = nil
    assert_not city.save
  end

  test 'should not have duplicate city/states' do
    city.save
    city2 = City.new(name: 'Orlando', state_id: 1)
    assert_not city2.save
    city3 = City.new(name: 'Orlando', state_id: 2)
    assert city3.save
  end

  test 'should not save without a state_id' do
    city.state_id = nil
    assert_not city.save
  end

end
