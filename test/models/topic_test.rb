require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  topic = Topic.new(name: 'Operating System')

  test 'should not save without a name' do
    topic.name = nil
    assert_not topic.save
  end

  test 'create_slug' do
    topic.save
    assert_equal 'operating-system', topic.slug
  end

  test 'strip extra whitespace before save' do
    topic.name = '   Operating   System   '
    topic.save
    assert_equal 'Operating System', topic.name
  end

end
