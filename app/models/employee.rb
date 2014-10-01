class Employee < ActiveRecord::Base
  has_many :tickets

	def last_first
		last_name + ', ' + first_name
	end
end
