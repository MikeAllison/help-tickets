class Ticket < ActiveRecord::Base
  belongs_to :employee
  belongs_to :topic
end
