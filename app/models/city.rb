class City < ActiveRecord::Base

  has_many :offices
  belongs_to :state

  validates_presence_of :name, message: 'Please enter a city name!'
  validates_uniqueness_of :name, scope: :state, message: 'This city/state already exists!'
  validates_presence_of :state, message: 'Please select a state!'

  before_save :create_slug

  scope :inactive,      -> { where(active: false) }
  scope :not_hidden,    -> { where(hidden: false) }

  def to_param
    slug
  end

  def city_state_abbr
    name + ', ' + state.abbreviation
  end

  private

    def create_slug
      self.slug = "#{name.gsub(/\s/, '-')}-#{self.state.abbreviation}".downcase
    end

end
