require 'test_helper'

class CityTest < ActiveSupport::TestCase
  def setup
    @c = cities(:orlando)
    @c2 = cities(:sanfran)
  end

  test 'test valid fixtures' do
    assert @c.valid?
    assert @c2.valid?
  end

  test 'should not save without a name' do
    assert_not_blank(@c, :name)
  end

  test 'should not allow save of duplicate city/states' do
    city = City.new(name: 'Orlando', state: states(:florida))
    assert_not city.save, 'Allowed save of duplicate city/state'
  end

  test 'should be able to save same city with different state' do
    city = City.new(name: 'Orlando', state: states(:texas))
    assert city.save
  end

  test 'should not save without a state' do
    assert_not_blank(@c, :state_id)
  end

  test 'should strip whitespace in name before saving' do
    should_strip_whitespace(@c, :name)
  end

  test 'city_state_abbr' do
    assert_equal 'Orlando, FL', @c.city_state_abbr
  end

  test 'unhide' do
    city = City.create(name: 'Tampa', state: states(:florida), hidden: true)
    city.unhide
    city.reload
    assert_not city.hidden
  end

  test 'create_slug' do
    @c2.save
    @c2.reload
    assert_equal 'san-francisco-ca', @c2.slug
  end
end
