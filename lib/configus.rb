Configus.build Rails.env do
  env :production
  env :staging, parent: :production do
    basic_auth do
      username 'ulmic_stg'
      password 'podporog'
    end
  end
  env :development, parent: :staging
  env :test, parent: :development
end
