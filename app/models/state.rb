class State < ActiveRecord::Base
  
  has_many :cities
  
  validates :name, presence: true
  validate :abbreviation, presence: true, length: 2
end
