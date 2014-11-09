class Ticket < ActiveRecord::Base
	
	before_save :set_topic, :set_status

  belongs_to :employee
  belongs_to :topic
  belongs_to :status

  validates :description, presence: true

  scope :open, -> { joins(:status).where.not('state = ?', 'Closed') }
  scope :unassigned, -> { joins(:status).where('state = ?', 'Unassigned') }
  scope :work_in_progress, -> { joins(:status).where('state = ?', 'Work in Progress') }
  scope :on_hold, -> { joins(:status).where('state = ?', 'On Hold') }
  scope :closed, -> { joins(:status).where('state = ?', 'Closed') }

  def set_topic
  end

  def set_status
  end

end