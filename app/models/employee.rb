class Employee < ActiveRecord::Base
  include Formatable

  has_secure_password validations: false

  has_many :originated_tickets, class_name: 'Ticket', foreign_key: 'originator_id'
  has_many :submitted_tickets, class_name: 'Ticket', foreign_key: 'submitter_id'
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'technician_id'
  has_many :comments
  belongs_to :office

  validates_presence_of :fname, message: 'Please enter a first name!'
  validates_presence_of :lname, message: 'Please enter a last name!'
  validates_presence_of :office_id, message: 'Please select an office!'
  validates_presence_of :password, message: 'Please enter a password!', on: :create
  #validates_presence_of :password_confirmation, message: 'Password Confirmation cannot be blank!', on: :create

  scope :active,     -> { where(active: true) }
  scope :inactive,   -> { where(active: false) }
  scope :technician, -> { where(technician: true) }
  scope :not_hidden, -> { where(hidden: false) }

  set_whitespace_stripable_attributes :fname, :lname

  before_save :set_username

  def to_param
    username
  end

	def last_first
    "#{lname}, #{fname}"
	end

	def first_last
    "#{fname} #{lname}"
	end

  def hide
    self.transaction do
      self.originated_tickets.each { |ticket| ticket.closed! }
      self.update(hidden: true)
    end
  end

  private

  def username_may_change?
    self.new_record? || self.fname_changed? || self.lname_changed?
  end

  def set_username
    first = fname.gsub(/\s+/, '')
    last = lname.gsub(/\s+/, '')
    username = f_last = "#{first[0]}#{last}".downcase
    count = 0

    if username_may_change?
      while Employee.find_by(username: username).present? && (username != self.username)
        username = "#{f_last}#{count += 1}"
      end
      self.username = username
    end
  end

end
