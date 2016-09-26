require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @c = comments(:comment1)
  end

  test 'test valid fixtures' do
    assert @c.valid?
  end

  test 'should not save without a body' do
    assert_not_blank(@c, :body)
  end

  test 'default status_type should be normal' do
    comment = Comment.new(body: 'Testing')
    comment.save
    comment.reload
    assert comment.normal?
  end
end
