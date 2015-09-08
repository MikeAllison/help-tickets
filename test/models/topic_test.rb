require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @t = topics(:os)
  end

  test 'should not save without a name' do
    assert_not_blank(@t, :name)
  end

  test 'should not save a duplicate topic' do
    t = Topic.new(name: 'Operating System')
    assert_not t.save, 'Allowed save of duplicate topic'
  end

  test 'should strip whitespace in name before save' do
    should_strip_whitespace(@t, :name)
  end

  test 'create_slug' do
    @t.save
    assert_equal 'operating-system', @t.slug
  end

end
