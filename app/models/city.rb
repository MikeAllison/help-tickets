class City < ActiveRecord::Base

  has_many :offices
  belongs_to :state

  # FIX THESE MESSAGES
  validates :name, presence: { message: '- Cannot be blank!' }
  validates :name, uniqueness: { scope: :state, message: '- City/State already exists!' }
  validates :state, presence: true

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
