class Topic < ActiveRecord::Base

  has_many :tickets

  validates :name, presence: true

  before_save :create_slug

  scope :active,        -> { where(active: true) }
  scope :not_hidden,    -> { where(hidden: false) }

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = name.gsub(/[^a-zA-Z0-9]/, '-').gsub(/-+/, '-').downcase
  end

end
