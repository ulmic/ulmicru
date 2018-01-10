Configus.build Rails.env do
  env :production do
    social_networks_pages do
      vkontakte 'http://vk.com/ulmic'
      instagram 'https://www.instagram.com/ulmicru/'
      twitter 'http://twitter.com/ulmicru'
      facebook 'https://www.facebook.com/molcenter'
      google_plus 'https://plus.google.com/b/109518417712111969312/109518417712111969312/posts'
      youtube 'https://www.youtube.com/user/ulmic73'
    end
    host 'ulmic.ru'
    full_host 'http://ulmic.ru'
    mailer do
      from 'mail@ulmic.ru'
    end
    api do
      foursquare do
        version '20140806'
      end
    end
    it_projects do
      ulmicru do
        google_analytics do
          uid 'UA-21756849-1'
        end
      end
      ul_lider do
        full_name 'organization.projects.ul_lider'
        url 'http://ul-lider.ru'
        ico 'organization/activity_lines/lider/ya-lider.png'
        chrome_extension do
          url 'https://chrome.google.com/webstore/detail/%D1%8F-%D0%BB%D0%B8%D0%B4%D0%B5%D1%80/lehbmnengpcoaledhaodhjcmibleffmd/'
        end
      end
      international_volunteer_school do
        full_name 'organization.projects.international_volunteer_school'
        url 'https://ulmic-volunteers-school.herokuapp.com/'
      end
      it_way do
        full_name 'organization.projects.it_way'
        short_name "IT Way'#{DateTime.now.strftime('%y')}"
        url 'http://it-way.pro'
        ico 'organization/activity_lines/it/it_way.png'
        google_analytics do
          uid 'UA-77805512-1'
        end
        social_links do
          vk 'http://vk.com/it_way'
          twitter 'http://twitter.com/developerslogs'
          instagram 'http://instagram.com/it_way'
          telegram 'http://t.me/it_way_chat'
        end
        links do
          lider 'http://ul-lider.ru'
          informat 'http://ulmic.ru/events/143'
          iamvolunteer 'http://ulmic-volunteers-school.herokuapp.com'
          aam 'http://ulmic.ru/events/69'
          ulmic 'http://ulmic.ru'
        end
      end
      karamzin do
        full_name 'organization.projects.karamzin.full_name'
        short_name 'organization.projects.karamzin.short_name'
        url 'https://karamzin.herokuapp.com'
      end
    end
    organization do
      logo 'http://ulmic.ru/assets/apps/logo-mic-square.png'
      logo_transparent 'http://ulmic.ru/assets/logo-transparent.png'
      found_date DateTime.new(2007, 02, 20)
    end
    #FIXME it will fixed on https://trello.com/c/MqBhJhpc/407-configus-dates ticket
    dates do
      activity_lines do
        corporative do
          confession do
            begining_submissions_petitions '06/12/2017'.to_datetime
            ending_submissions_petitions '11/01/2018'.to_datetime
            begining_voting '11/01/2018'.to_datetime
            ending_voting '17/01/2018'.to_datetime
          end
        end
      end
    end
    activity_lines do
      corporative do
        confession do
          article_id 25
        end
        merit do
          first_degree do
            article_id 2
          end
          second_degree do
            article_id 7
          end
        end
      end
      lider do
        ya_lider do
          current_contest_number 15
        end
      end
    end
    people do
      headers do
        corporative 238
      end
    end
    categories do
      who_we_are 2
      site_mic 12
      corporative_projects 14
      contacts 3
    end
    articles do
      contacts 16
      contact_list 78
      charter 20
      confession 25
      who_we_are 11
      open_departament 76
      requisites 15
    end
    documents do
      confession_position 4
    end
    sites do
      ulnc 'http://ulnc.ru'
      ministry_of_edu 'http://mo73.ru/'
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
    it_projects do
      ul_lider do
        url 'http://localhost:3001'
      end
    end
  end
  env :test, parent: :development
end
