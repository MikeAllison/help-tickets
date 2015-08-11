require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'comment cannot be blank' do
    comment = comments(:comment1)
    comment.body = nil
    assert_not comment.save
  end

  test 'default status_type should be normal' do
    comment = Comment.new(body: 'Testing')
    comment.save
    assert_equal true, comment.normal?
  end

end
