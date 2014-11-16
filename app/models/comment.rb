class Comment < ActiveRecord::Base
  
  belongs_to :ticket
  belongs_to :employee
  
  validates :body, presence: true
  
end