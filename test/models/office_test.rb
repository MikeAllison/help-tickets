require 'test_helper'

class OfficeTest < ActiveSupport::TestCase

  def setup
    @o = offices(:maitland)
    @o2 = offices(:fishermans)
  end

  test 'name cannot be blank' do
    @o.name = ''
    assert_not @o.save
  end

  test 'city_id cannot be blank' do
    @o.city_id = nil
    assert_not @o.save
  end

  test 'office_city_state_abbr' do
    assert_equal 'Maitland - Orlando, FL', @o.office_city_state_abbr
  end

  test 'create_slug' do
    @o2.save
    assert_equal 'fishermans-wharf-san-francisco-ca', @o2.slug
  end

end
