require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @t = topics(:os)
  end

  test 'test valid fixtures' do
    assert @t.valid?
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

  test 'unhide' do
    topic = Topic.create(name: 'Mouse', hidden: true)
    topic.unhide
    assert_not topic.hidden
  end

  test 'create_slug' do
    @t.save
    assert_equal 'operating-system', @t.slug
  end

end
