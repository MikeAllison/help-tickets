class Ticket < ActiveRecord::Base

	enum status: [:unassigned, :work_in_progress, :on_hold, :closed]

	before_save :set_default_status

  has_many :attachments
  has_many :comments
  belongs_to :creator, class_name: 'Employee'
  belongs_to :technician, class_name: 'Employee'
  belongs_to :topic

	# Tickets can be created/updated without assigning a technician
  # But there should be some validation for valid techician IDs
	validates_presence_of :creator_id, message: 'Please select an employee!'
	validates_presence_of :topic_id, message: 'Please select a topic!'
	validates_presence_of :description, message: 'Please enter a description of the problem!'

  scope :no_descriptions,  -> { select('id', 'creator_id', 'topic_id', 'technician_id', 'status', 'created_at', 'updated_at') }
  scope :open,             -> { where.not('status = ?', 'Closed') }

	def reopen(current_employee)
		if current_employee.technician?
			self.update(status: :work_in_progress, technician_id: current_employee.id)
		else
			self.update(status: :unassigned, technician_id: nil)
		end
	end

	def close(current_employee)
		self.transaction do
			self.closed!
			self.update(technician_id: current_employee.id)	if current_employee.technician?
		end
	end

	private

    # Tickets can be submitted without a status and are set to 'Unassigned'
    def set_default_status
      self.unassigned! if self.status.nil?
		end

    # Set pagination for will_paginate
    self.per_page = 20

end
