Configus.build Rails.env do
  env :production do
    social_networks_pages do
      vkontakte 'http://vk.com/ulmic'
      twitter 'http://twitter.com/ulmicru'
      facebook 'https://www.facebook.com/molcenter'
      google_plus 'https://plus.google.com/b/109518417712111969312/109518417712111969312/posts'
    end
    host 'ulmic.ru'
    full_host 'http://ulmic.ru'
    mailer do
      from "noreply@ulmic.ru"
    end
    api do
      foursquare do
        version '20140806'
      end
    end
    it_projects do
      ul_lider do
        full_name 'organization.projects.ul_lider'
        url 'http://ul-lider.ru'
      end
      international_volunteer_school do
        full_name 'organization.projects.international_volunteer_school'
        url 'https://ulmic-volunteers-school.herokuapp.com/'
      end
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
