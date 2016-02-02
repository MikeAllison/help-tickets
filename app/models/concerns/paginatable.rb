module Paginatable
  extend ActiveSupport::Concern

  ITEMS_PER_PAGE = 12

  module ClassMethods
    def default_scope
      limit(ITEMS_PER_PAGE)
    end
  end

end
