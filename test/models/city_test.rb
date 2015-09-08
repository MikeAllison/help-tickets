require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @c = cities(:orlando)
  end

  test 'should not save without a name' do
    @c.name = ''
    assert_not @c.save
  end

  test 'should not have duplicate city/states' do
    city1 = cities(:orlando)
    city2 = City.new(name: 'Orlando', state_id: states(:florida).id)
    assert_not city2.save
  end

  test 'should be able to save same city with different state' do
    city2 = City.new(name: 'Orlando', state_id: states(:texas).id)
    assert city2.save
  end

  test 'should not save without a state_id' do
    @c.state_id = nil
    assert_not @c.save
  end

end
