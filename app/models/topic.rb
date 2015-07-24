class Topic < ActiveRecord::Base

  has_many :tickets

  validates :name, presence: true

  scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

end
