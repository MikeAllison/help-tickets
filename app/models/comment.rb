class Comment < ActiveRecord::Base
  
  belongs_to :ticket, dependent: :destroy
  belongs_to :employee
  
  validates :body, presence: true
  
end