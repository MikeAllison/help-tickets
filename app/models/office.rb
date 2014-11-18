class Office < ActiveRecord::Base

	has_many :employees
	
	validates :name, presence: true

  private
    
    # Set pagination for will_paginate
    self.per_page = 20
end