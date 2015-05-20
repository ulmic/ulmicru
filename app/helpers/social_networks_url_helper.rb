module SocialNetworksUrlHelper
  def profile_url(auth)
    social_networks = { vkontakte: 'vk.com',
                        facebook: 'facebook.com',
                        twitter: 'twitter.com',
                        google: 'plus.google.com' }.with_indifferent_access
    "http://#{social_networks[auth.provider]}/#{auth.provider == 'vkontakte' ? 'id' : ''}#{auth.uid}"
  end
end
