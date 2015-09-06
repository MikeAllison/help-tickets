module Formatable
  extend ActiveSupport::Concern

  included do
    class_attribute :whitespace_stripped_attributes
    before_validation :strip_whitespace
  end

  module ClassMethods
    def set_whitespace_stripable_attributes(*attr_name)
      self.whitespace_stripped_attributes = attr_name
    end
  end

  private

  def strip_whitespace()
    self.whitespace_stripped_attributes.each do |attr|
      self.send("#{attr}=", self.send(attr).squish)
    end
  end

end
