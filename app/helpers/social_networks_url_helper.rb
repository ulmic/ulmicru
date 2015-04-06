module SocialNetworksUrlHelper
  def profile(auth)
    social_networks = { vkontakte: 'vk.com',
                        facebook: 'facebook.com',
                        twitter: 'twitter.com',
                        google: 'plus.google.com' }
    "http://#{social_networks[auth.provider]}/#{auth.uid}"
  end
end
