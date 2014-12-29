class State < ActiveRecord::Base
  
  has_many :cities
  
  validates :name, presence: true
  validates :abbreviation, presence: true, length: { is: 2 }
  
end
