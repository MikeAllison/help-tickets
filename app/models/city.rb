class City < ActiveRecord::Base
  
  has_many :offices
  belongs_to :state
  
  validates :name, presence: true
  
  scope :not_hidden,    -> { where(hidden: false) }
  
  def city_state_abbr
    name + ', ' + state.abbreviation
  end
  
end