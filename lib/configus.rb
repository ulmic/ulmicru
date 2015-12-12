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
      from 'noreply@ulmic.ru'
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
      it_way do
        full_name 'organization.projects.it_way'
        url 'https://it-way.herokuapp.com'
      end
    end
    organization do
      logo 'http://ulmic.ru/assets/apps/logo-mic-square.png'
    end
    #FIXME it will fixed on https://trello.com/c/MqBhJhpc/407-configus-dates ticket
    dates do
      activity_lines do
        corporative do
          confession do
            begining_submissions_petitions '21/12/2015'.to_datetime
            ending_submissions_petitions '10/01/2016'.to_datetime
            begining_voting '11/01/2016'.to_datetime
            ending_voting '16/01/2016'.to_datetime
          end
        end
      end
    end
  end

  env :staging, parent: :production do
    basic_auth do
      username 'ulmic_stg'
      password 'podporog'
    end
    host 'staging.ulmic.ru'
    full_host 'http://staging.ulmic.ru'
    mailer do
      from "noreply@ulmic.ru"
    end
  end
  env :development, parent: :staging do
    host 'localhost:3000'
    full_host 'http://localhost:3000'
  end
  env :test, parent: :development
end
