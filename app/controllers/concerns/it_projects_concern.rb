module Concerns
  module ItProjectsConcern
    def main_page(it_project_name)
      page_path it_project_name.split('.')[0].gsub('-', '_')
    end
  end
end
