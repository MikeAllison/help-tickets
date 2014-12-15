class Attachment < ActiveRecord::Base
  belongs_to :ticket, dependent: :destroy
end
