module UlmicProjectsHelper

  ### Navbar links

  def ul_lider_link
    link_to configus.it_projects.ul_lider.url, class: :blank do
      content_tag :div, class: :inner do
        concat image_tag 'organization/activity_lines/lider/ya-lider.png', class: 'custom-icon'
        concat content_tag :span, " #{t('organization.projects.i_am_lider')}"
      end
    end
  end

  def it_way_link
    link_to configus.it_projects.it_way.url, class: :blank do
      content_tag :div, class: :inner do
        concat image_tag 'organization/activity_lines/it/it_way.png', class: 'custom-icon'
        concat content_tag :span, " #{t('organization.projects.it_way')}'16"
      end
    end
  end
end
