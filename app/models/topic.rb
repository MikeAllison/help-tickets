class Topic < ActiveRecord::Base
  has_many :tickets
end
