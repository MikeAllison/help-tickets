class City < ActiveRecord::Base
  
  has_many :offices
  belongs_to :state
  
  validates :name, presence: { message: '- Cannot be blank!' }
  validates :name, uniqueness: { scope: :state, message: '- City/State already exists!' }
  validates :state, presence: true
    
  scope :inactive,      -> { where(active: false) }
  scope :not_hidden,    -> { where(hidden: false) }
  
  def city_state_abbr
    name + ', ' + state.abbreviation
  end
  
end