module Concerns
  module TechinalPagesManagment
    def not_found_page_path
      page_page_path :not_found
    end

    def server_error_page_path
      page_page_path :server_error
    end
  end
end
