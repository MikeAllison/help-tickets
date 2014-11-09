class Status < ActiveRecord::Base
  
  has_many :tickets

  validates :state, presence: true

end