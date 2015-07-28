class State < ActiveRecord::Base

  has_many :cities

  validates_presence_of :name, message: 'Please enter a state name!'
  validates_presence_of :abbreviaton, message: 'Please enter an abbreviation!'
  validates_length_of :abbreviaton, is: 2, message: 'Abbreviation must be two letters!'

end
