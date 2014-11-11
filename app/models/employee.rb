class Employee < ActiveRecord::Base

  before_save { self.user_name = user_name.downcase }
  
  has_many :tickets
  belongs_to :office
  
  validates :first_name, :last_name, :office_id, presence: true
  validates :user_name, presence: true, uniqueness: true

  # Method to set user name

	def last_first
		last_name + ', ' + first_name
	end
	
	has_secure_password
	validates :password, length: { minimum: 8 }

end