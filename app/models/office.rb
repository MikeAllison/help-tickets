class Office < ActiveRecord::Base
	include Formatable

	has_many :employees
	belongs_to :city

	validates_presence_of :name, message: 'Please enter an office name!'
	validates_presence_of :city_id, message: 'Please select a city/state!'

	before_save :create_slug

	scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

	set_whitespace_stripable_attributes :name

	def to_param
		slug
	end

  def office_city_state_abbr
		"#{self.name} - #{self.city.name}, #{self.city.state.abbreviation}"
  end

  private

	def create_slug
		office = self.name.gsub(/[^\w\s]/, '').gsub(/\s+/, '-')
		city = self.city.name.gsub(/[^\w\s]/, '').gsub(/\s+/, '-')
		state_abbr = self.city.state.abbreviation

		self.slug = "#{office}-#{city}-#{state_abbr}".downcase
	end

  # Set pagination for will_paginate
  self.per_page = 20

end
