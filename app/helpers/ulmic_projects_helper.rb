module UlmicProjectsHelper

  ### Navbar links
  
  def ulmic_project_link(project)
    project_config = configus.it_projects.send project
    link_to project_config.url, class: :blank do
      content_tag :div, class: :inner do
        concat image_tag project_config.ico, class: 'custom-icon'
        concat content_tag :span, " #{project_config.short_name}"
      end
    end
  end
end
