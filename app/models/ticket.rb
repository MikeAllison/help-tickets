class Ticket < ActiveRecord::Base
  enum status: [:unassigned, :work_in_progress, :on_hold, :closed]
  enum priority: [:normal, :urgent]

  has_many :attachments
  has_many :comments
  belongs_to :originator, class_name: 'Employee'
  belongs_to :submitter, class_name: 'Employee'
  belongs_to :technician, class_name: 'Employee'
  belongs_to :topic

  # Tickets can be created/updated without assigning a technician
  # But there should be some validation for valid techician IDs
  validates_presence_of :originator_id, message: 'Please select an employee!'
  validates_presence_of :submitter_id, message: 'There was a problem submitting the ticket.  Please try again!'
  validates_presence_of :topic_id, message: 'Please select a topic!'
  validates_presence_of :description, message: 'Please enter a description of the problem!'

  before_save :set_default_status
  before_save :set_default_priority

  scope :no_descriptions, -> { select('id', 'originator_id', 'submitter_id', 'topic_id', 'technician_id', 'status', 'priority', 'created_at', 'updated_at') }
  scope :open,            -> { where.not('status = ?', 3) }

  # Pagination settings
  def self.items_per_page
    12
  end

  def self.default_scope
    self.limit(self.items_per_page)
  end
  # End pagination settings

  def reopen(employee)
    if employee.technician?
      self.update(status: :work_in_progress, technician: employee, closed_at: nil)
    else
      self.update(status: :unassigned, technician: nil, closed_at: nil)
    end
  end

  def close(employee)
    self.transaction do
      self.closed!
      self.closed_at = Time.now
      self.update(technician: employee)	if employee.technician?
      self.save
    end
  end

  def open?
    !self.closed?
  end

  def total_seconds_open_as_i
    time_in_seconds = self.open? ? (Time.now - self.created_at) : (self.closed_at - self.created_at)
    time_in_seconds.to_i
  end

  private

  # Tickets can be submitted without a status and are set to 'Unassigned'
  def set_default_status
    self.unassigned! if self.status.nil?
  end

  def set_default_priority
    self.normal! if self.priority.nil?
  end

end
