class City < ActiveRecord::Base
  
  has_many :offices
  belongs_to :state
  
  validates :name, presence: true
  
  def city_state_abbr
    name + ', ' + state.abbreviation
  end
  
end