class Comment < ActiveRecord::Base
  before_save :set_employee_id
  
  belongs_to :ticket
  belongs_to :employee
  
  validates :body, presence: true
  
  private
  
  def set_employee_id
    # Trying to set to the id of the logged in employee from SessionsHelper
    self.employee_id = 1
  end
end