class Office < ActiveRecord::Base

	has_many :employees
	belongs_to :city
	
	validates :name, presence: true
	
	scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

  def office_city_state_abbr
    name + ' - ' + self.city.city_state_abbr
  end
    
  private
    
    # Set pagination for will_paginate
    self.per_page = 20
end