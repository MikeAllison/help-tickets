require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @t = topics(:os)
  end

  test 'should not save without a name' do
    @t.name = ''
    assert_not @t.save
  end

  test 'create_slug' do
    @t.save
    assert_equal 'operating-system', @t.slug
  end

  test 'strip extra whitespace before save' do
    @t.name = '   Operating   System   '
    @t.save
    assert_equal 'Operating System', @t.name
  end

end
