require 'test_helper'

class OfficeTest < ActiveSupport::TestCase

  def setup
    @o = offices(:maitland)
    @o2 = offices(:fishermans)
  end

  test 'test valid fixtures' do
    assert @o.valid?
    assert @o2.valid?
  end

  test 'should not save without a name' do
    assert_not_blank(@o, :name)
  end

  test 'should not save without a city_id' do
    assert_not_blank(@o, :city_id)
  end

  test 'should strip whitespace in name before save' do
    should_strip_whitespace(@o, :name)
  end

  test 'office_city_state_abbr' do
    assert_equal 'Maitland - Orlando, FL', @o.office_city_state_abbr
  end

  test 'create_slug' do
    @o2.save
    @o2.reload
    assert_equal 'fishermans-wharf-san-francisco-ca', @o2.slug
  end

end
