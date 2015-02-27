OAUTH_KEYS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, OAUTH_KEYS[:google_client_id], OAUTH_KEYS[:google_client_secret],
  {
    name: "google",
    scope: "email, profile, plus.me",
    provider_ignores_state: true,
    prompt: "select_account",
    image_aspect_ratio: "square",
    image_size: 50
  }
end
