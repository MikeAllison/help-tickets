require 'test_helper'

class OfficeTest < ActiveSupport::TestCase

  test 'name cannot be blank' do
    office = offices(:maitland)
    office.name = nil
    assert_not office.save
  end

  test 'city_id cannot be blank' do
    office = offices(:maitland)
    office.city_id = nil
    assert_not office.save
  end

  test 'office_city_state_abbr' do
    office = offices(:maitland)
    assert_equal 'Maitland - Orlando, FL', office.office_city_state_abbr
  end

  test 'create_slug' do
    office = offices(:fishermans)
    office.save
    assert_equal 'fishermans-wharf-san-francisco-ca', office.slug
  end

end
