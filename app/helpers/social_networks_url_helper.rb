module SocialNetworksUrlHelper
  def profile_url(auth)
    social_networks = { vkontakte: 'vk.com',
                        facebook: 'facebook.com',
                        twitter: 'twitter.com',
                        google: 'plus.google.com' }.with_indifferent_access
    if auth.provider == 'vkontakte'
      "http://#{social_networks[auth.provider]}/id#{auth.uid}"
    elsif auth.provider == 'twitter'
      "http://#{social_networks[auth.provider]}/intent/user?user_id=#{auth.uid}"
    else
      "http://#{social_networks[auth.provider]}/#{auth.uid}"
    end
  end

  def social_network_icon(provider, size, colored = false)
    "icon-#{provider} #{size}-icon #{colored}"
  end
end
