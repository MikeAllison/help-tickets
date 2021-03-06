class City < ActiveRecord::Base
  include Formatable

  has_many :offices
  belongs_to :state

  validates_presence_of :name, message: 'Please enter a city name!'
  validates_uniqueness_of :name, scope: :state, case_sensitive: false, message: 'This city/state already exists!'
  validates_presence_of :state_id, message: 'Please select a state!'

  set_whitespace_stripable_attributes :name

  before_save :create_slug

  scope :inactive,   -> { where(active: false) }
  scope :hidden,     -> { where(hidden: true) }
  scope :not_hidden, -> { where(hidden: false) }

  def to_param
    slug
  end

  def city_state_abbr
    name + ', ' + state.abbreviation
  end

  def unhide
    self.hidden = false
    self.save
  end

  private

  def create_slug
    self.slug = "#{name.gsub(/\s/, '-')}-#{self.state.abbreviation}".downcase
  end

end
