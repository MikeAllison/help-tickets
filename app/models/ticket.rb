class Ticket < ActiveRecord::Base

	enum status: [:unassigned, :work_in_progress, :on_hold, :closed]

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

  scope :no_descriptions, -> { select('id', 'originator_id', 'submitter_id', 'topic_id', 'technician_id', 'status', 'created_at', 'updated_at') }
  scope :open,            -> { where.not('status = ?', 3) }

	def reopen(employee)
		if employee.technician?
			self.update(status: :work_in_progress, technician: employee)
		else
			self.update(status: :unassigned, technician: nil)
		end
	end

	def close(employee)
		self.transaction do
			self.closed!
			self.update(technician: employee)	if employee.technician?
		end
	end

	private

	def set_submitter
		self.submitter = current_employee
	end

  # Tickets can be submitted without a status and are set to 'Unassigned'
  def set_default_status
    self.unassigned! if self.status.nil?
	end

  # Set pagination for will_paginate
  self.per_page = 20

end
