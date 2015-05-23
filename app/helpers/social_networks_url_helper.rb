module SocialNetworksUrlHelper
  def profile_url(auth)
    social_networks = { vkontakte: 'vk.com',
                        facebook: 'facebook.com',
                        twitter: 'twitter.com',
                        google: 'plus.google.com' }.with_indifferent_access
    "http://#{social_networks[auth.provider]}/#{auth.provider == 'vkontakte' ? 'id' : ''}#{auth.uid}"
  end

  def social_network_icon(provider, size, colored = false)
    "icon-#{provider} #{size}-icon #{colored}"
  end
end
