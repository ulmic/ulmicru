module Concerns
  module ItProjectsConcern
    def main_page_of(it_project_name)
      if it_project_name == 'ul-lider.ru'
        activity_lines_lider_ya_liders(15)
      else
        page_page_path it_project_name.gsub('www.', '').split('.')[0].gsub('-', '_')
      end
    end
  end
end
