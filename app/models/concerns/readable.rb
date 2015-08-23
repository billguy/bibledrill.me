module Readable
  extend ActiveSupport::Concern

  included do
    def prev
      id == 1 ? self.class.last : self.class.find_by_id(id-1)
    end
    def next
      id == self.class.count ? self.class.first : self.class.find_by_id(id+1)
    end
  end
end
