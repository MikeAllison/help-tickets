class Employee < ActiveRecord::Base

  has_secure_password validations: false

  before_create :set_user_name

  has_many :created_tickets, class_name: 'Ticket', foreign_key: 'creator_id'
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'technician_id'
  has_many :comments
  belongs_to :office

  validates_presence_of :first_name, message: 'Please enter a first name!'
  validates_presence_of :last_name, message: 'Please enter a last name!'
  validates_presence_of :office_id, message: 'Please select an office!'
  validates_presence_of :password, message: 'Please enter a password!', on: :create
  #validates_presence_of :password_confirmation, message: 'Password Confirmation cannot be blank!', on: :create

  scope :active,     -> { where(active: true) }
  scope :inactive,   -> { where(active: false) }
  scope :technician, -> { where(technician: true) }
  scope :not_hidden, -> { where(hidden: false) }

  def to_param
    user_name
  end

	def last_first
    "#{last_name}, #{first_name}"
	end

	def first_last
    "#{first_name} #{last_name}"
	end

  def hide
    self.transaction do
      self.created_tickets.each { |ticket| ticket.closed! }
      self.update(hidden: true)
    end
  end

  private

    def set_user_name
      first = first_name.gsub(/\s+/, '')
      last = last_name.gsub(/\s+/, '')
      user_name = f_last = "#{first[0]}#{last}".downcase
      count = 0

      while Employee.find_by(user_name: user_name).present?
        user_name = "#{f_last}#{count += 1}"
      end

      self.user_name = user_name
    end

end
