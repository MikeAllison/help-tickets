require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @c = comments(:comment1)
  end

  test 'comment cannot be blank' do
    @c.body = ''
    assert_not @c.save
  end

  test 'default status_type should be normal' do
    comment = Comment.new(body: 'Testing')
    comment.save
    assert_equal true, comment.normal?
  end

end
