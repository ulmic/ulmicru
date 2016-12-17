class Oauth::AppForm < ApplicationReform
  properties :title, :url, :client_id, :client_secret, :state, :callback_url
end
