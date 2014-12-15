class Ticket < ActiveRecord::Base
	
	before_save :set_status

  has_many :attachments
  has_many :comments
  belongs_to :creator, class_name: 'Employee'
  belongs_to :technician, class_name: 'Employee'
  belongs_to :topic
  belongs_to :status

  validates :description, :topic, presence: true

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
    
    # # Set pagination for will_paginate
    self.per_page = 20

end