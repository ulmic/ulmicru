OAUTH_KEYS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, OAUTH_KEYS[:google][:client_id], OAUTH_KEYS[:google][:client_secret],
  {
    name: "google",
    scope: "email, profile, plus.me",
    provider_ignores_state: true,
    prompt: "select_account",
  }
  provider :vkontakte, OAUTH_KEYS[:vk][:client_id], OAUTH_KEYS[:vk][:client_secret]
  provider :twitter, OAUTH_KEYS[:twitter][:client_id], OAUTH_KEYS[:twitter][:client_secret]
  provider :facebook, OAUTH_KEYS[:facebook][:client_id], OAUTH_KEYS[:facebook][:client_secret]
end
