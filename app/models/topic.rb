class Topic < ActiveRecord::Base

  has_many :tickets

  validates_presence_of :name, message: 'Please enter a topic name!'

  before_save :strip_extra_whitespace
  before_save :create_slug

  scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

  def to_param
    slug
  end

  private

  def strip_extra_whitespace
    self.name.squish!
  end

  def create_slug
    self.slug = name.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').downcase
  end

end
