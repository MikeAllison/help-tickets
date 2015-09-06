class Topic < ActiveRecord::Base
  include Formatable

  has_many :tickets

  validates_presence_of :name, message: 'Please enter a topic name!'
  validates_uniqueness_of :name, message: 'This topic already exists!'

  before_save :strip_extra_whitespace
  before_save :create_slug

  scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

  set_whitespace_stripable_attributes :name

  def to_param
    slug
  end

  def unhide
    self.hidden = false
    self.save
  end

  private

  def strip_extra_whitespace
    self.name.squish!
  end

  def create_slug
    self.slug = name.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').downcase
  end

end
