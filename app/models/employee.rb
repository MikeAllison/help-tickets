class Employee < ActiveRecord::Base
  
  has_secure_password

  before_save { self.user_name = user_name.downcase }
  
  has_many :created_tickets, class_name: 'Ticket', foreign_key: 'creator_id', dependent: :destroy
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'technician_id'
  has_many :comments
  belongs_to :office
  
  validates :first_name, :last_name, :office, presence: true
  validates :user_name, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_blank: true
  
  scope :active,      -> { where(active: true) }
  scope :inactive,    -> { where(active: false) }
  scope :admin,       -> { where(admin: true) }
  scope :not_hidden,  -> { where(hidden: false) }

  # Create method to set user name
  
	def last_first
		last_name + ', ' + first_name
	end
	
	def first_last
	  first_name + ' ' + last_name
	end

end