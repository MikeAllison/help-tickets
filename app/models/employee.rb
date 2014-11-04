class Employee < ActiveRecord::Base
  before_save { self.user_name = user_name.downcase }
  
  has_many :tickets
  
  scope :admin, -> { where(admin: true) }

	def last_first
		last_name + ', ' + first_name
	end
	
	has_secure_password
	validates :password, length: { minimum: 8 }
end
