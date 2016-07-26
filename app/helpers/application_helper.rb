module ApplicationHelper
  include Concerns::AuthManagment
  include ActionView::Helpers
  include DatesHelper

  def title(page_title = default_title, area = :default)
    if area != :default
      title_text = "#{page_title} | #{t(area)} | #{t('application.name')}"
    elsif page_title == :app_name
      title_text = t('application.name')
    else
      title_text = "#{page_title} | #{t('application.name')}"
    end
    content_for(:title) { title_text }
  end

  def default_title
    t('.title')
  end

  def admin_menu_item(name, url, icon = nil)
    title = name.is_a?(Class) ? name.model_name.human.pluralize(:ru) : name
    if icon
      menu_item url do
        concat icon_element icon
        concat ' '
        concat title
      end
    else
      menu_item title, url
    end
  end

  def admin_trash_menu_item(type)
    menu_item type.model_name.human.pluralize(:ru), type_admin_trash_index_path(to_trash_param(type))
  end

  def auth_path(provider, **http_params)
    session[:redirect_url] = http_params[:url]
    "/auth/#{provider}"
  end

  include SocialNetworks

  def social_network_localize(provider)
    I18n.t("social_networks.#{provider}")
  end

  def not_linked_social_networks(authentications)
    list = SocialNetworks.list
    authentications.each do |auth|
      list -= [ auth.provider ]
    end
    list
  end

  def oauth_key(provider, key)
    YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access[provider][key]
  end

  def google_api_key
    YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access[:google][:api_key]
  end

  def google_map_src(address)
    "https://www.google.com/maps/embed/v1/search?q=" + address.split.join("+") + "&key=" + google_api_key
  end
end
