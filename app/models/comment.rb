class Comment < ActiveRecord::Base
  enum status_type: [:normal, :reopening, :closing]

  before_save :set_default_status_type

  belongs_to :ticket, dependent: :destroy
  belongs_to :employee

  validates_presence_of :body, message: 'Comment cannot be blank!'

  private

  def set_default_status_type
    self.normal! if self.status_type.nil?
  end

end
