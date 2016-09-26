module Concerns
  module ReviewManagment
    def need_to_review?
      self.unviewed? or self.updated?
    end
  end
end
