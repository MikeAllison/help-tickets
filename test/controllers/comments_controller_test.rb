require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
  end

  # test 'non-techs should be able to comment on their own open tickets' do
  #   functional_log_in(@active_tech)
  #
  #   post :create, comment: { body: 'Test', ticket: @ticket_unassigned }
  #   assert_equal 'Comment added!', flash[:success]
  #
  #   post :create, comment: { body: 'Test', ticket: @ticket_wip }
  #   assert_equal 'Comment added!', flash[:success]
  #
  #   post :create, comment: { body: 'Test', ticket: @ticket_hold }
  #   assert_equal 'Comment added!', flash[:success]
  # end

  # NOT CORRECT - Closing of a ticket is initiated in CommentsController
  # test 'non-techs should be able to close their own tickets' do
  #   functional_log_in(@active_tech)
  #   @t.close(@active_nontech)
  #   @t.reload
  #   assert @t.closed?
  # end
  #
  # test 'non-techs SHOULD NOT be able to close others tickets' do
  #   functional_log_in(@active_tech)
  #   @t.close(@active_nontech_2)
  #   @t.reload
  #   assert !@t.closed?
  # end

  # NOT CORRECT - Reopening of a ticket is initiated in CommentsController
  # test 'non-techs should be able to reopen their own closed tickets' do
  # end
  #
  # test 'non-techs SHOULD NOT be able to reopen others closed tickets' do
  # end
end
