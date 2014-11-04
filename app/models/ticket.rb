class Ticket < ActiveRecord::Base
  belongs_to :employee
  belongs_to :topic
  belongs_to :status
end
