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

  def menu_item(name = nil, path = '#', *args, &block)
    path = name || path if block_given?
    options = args.extract_options!
    content_tag :li, class: is_active?(path, options) do
      name, path = path, options if block_given?
      link_to name, path, options, &block
    end
  end

  def is_active?(path, options = {})
    'active' if uri_state(path, options).in? [:active, :chosen]
  end

  def uri_state(uri, options = {})
    root_url = request.host_with_port + '/'
    root = uri == '/' || uri == root_url
    request_uri = if uri.start_with? root_url
                    request.url
                  else
                    request.path
                  end
    if !options[:method].nil? || !options["data-method"].nil?
      :inactive
    elsif uri == request_uri || (options[:root] && (request_uri == '/') || (request_uri == root_url))
      :active
    else
      if request_uri.start_with?(uri) and not(root)
        :chosen
      else
        :inactive
      end
    end
  end

  def dropdown(text, icon = nil, &block)
    content_tag :li, class: :drowdown do
      concat(link_to('#', class: 'dropdown-toggle', data: { toggle: :dropdown }) do
	if icon
	  concat content_tag :span, '', class: "glyphicon glyphicon-#{icon}"
	  concat ' '
	end
	concat text
	unless icon
	  concat ' '
	  concat content_tag :span, '', class: :caret
	end
      end)
      concat(content_tag(:ul, class: 'dropdown-menu') do
	yield block
      end)
    end
  end

  def auth_path(provider)
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
end
