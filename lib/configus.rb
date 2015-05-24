Configus.build Rails.env do
  env :production do
    social_networks_pages do
      vkontakte 'http://vk.com/ulmic'
      twitter 'http://twitter.com/ulmicru'
      facebook 'https://www.facebook.com/molcenter'
      google_plus 'https://plus.google.com/b/109518417712111969312/109518417712111969312/posts'
    end
    host 'ulmic.ru'
    mailer do
      from "noreply@ulmic.ru"
    end
  end

  env :staging, parent: :production do
    basic_auth do
      username 'ulmic_stg'
      password 'podporog'
    end
  end
  env :development, parent: :staging
  env :test, parent: :development
end
