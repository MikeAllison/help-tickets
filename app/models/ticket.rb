class Ticket < ActiveRecord::Base
	
	before_save :set_status

  has_many :attachments
  has_many :comments
  belongs_to :creator, class_name: 'Employee'
  belongs_to :technician, class_name: 'Employee'
  belongs_to :topic
  belongs_to :status

  validates :creator, :description, :topic, presence: true
  # Tickets can be created/updated without assigning a technician
  # But there should be some validation for valid techician IDs
  
  # Tickets can be submitted without a status and are set to unassigned
  # Status should be checked to make sure that it is valid

  scope :no_descriptions,  -> { select('id', 'creator_id', 'topic_id', 'status_id', 'technician_id', 'created_at', 'updated_at') }
  scope :open,             -> { joins(:status).where.not('state = ?', 'Closed') }
  scope :unassigned,       -> { joins(:status).where('state = ?', 'Unassigned') }
  scope :work_in_progress, -> { joins(:status).where('state = ?', 'Work in Progress') }
  scope :on_hold,          -> { joins(:status).where('state = ?', 'On Hold') }
  scope :closed,           -> { joins(:status).where('state = ?', 'Closed') }
    
  private
  
    # Sets default ticket status to 'Unassigned'
    # Will break if statuses are renamed
    # Check Hartl 4.4.5
    def set_status
      if status_id.nil?
        self.status_id = 1
      end
    end
    
    # Set pagination for will_paginate
    self.per_page = 20

end