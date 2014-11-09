class Topic < ActiveRecord::Base
  
  has_many :tickets

  validates :system, presence: true

end