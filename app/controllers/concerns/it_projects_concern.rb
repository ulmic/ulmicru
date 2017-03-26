module Concerns
  module ItProjectsConcern
    def main_page_of(it_project_name)
      page_page_path it_project_name.gsub('www.', '').split('.')[0].gsub('-', '_')
    end
  end
end
