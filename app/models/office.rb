class Office < ActiveRecord::Base

	has_many :employees
	belongs_to :city

	validates :name, :city, presence: true

	before_save :create_slug

	scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

	def to_param
		slug
	end

  def office_city_state_abbr
    name + ' - ' + self.city.city_state_abbr
  end

  private

		def create_slug
			self.slug = "#{name.delete("'")}-#{self.city.name}-#{self.city.state.abbreviation}".downcase.gsub(/\s/, '-')
		end

    # Set pagination for will_paginate
    self.per_page = 20

end
