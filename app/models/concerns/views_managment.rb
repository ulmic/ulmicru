module Concerns
  module ViewsManagment
    def increase_views
      update views: (views + 1)
    end
  end
end
