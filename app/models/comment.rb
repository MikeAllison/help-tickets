class Comment < ActiveRecord::Base

  belongs_to :ticket, dependent: :destroy
  belongs_to :employee

  validates_presence_of :body, message: 'Comment cannot be blank!'

end
