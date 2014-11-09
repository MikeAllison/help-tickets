class Ticket < ActiveRecord::Base
  belongs_to :employee
  belongs_to :topic
  belongs_to :status
  
  scope :open, -> { joins(:status).where.not('state = ?', 'Closed') }
  scope :unassigned, -> { joins(:status).where('state = ?', 'Unassigned') }
  scope :work_in_progress, -> { joins(:status).where('state = ?', 'Work in Progress') }
  scope :on_hold, -> { joins(:status).where('state = ?', 'On Hold') }
  scope :closed, -> { joins(:status).where('state = ?', 'Closed') }
end
