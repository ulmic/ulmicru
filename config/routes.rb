require 'sidekiq/web'
# -*- coding: utf-8 -*-
Rails.application.routes.draw do
  mount RailsEmailPreview::Engine, at: 'emails'
  mount Sidekiq::Web => '/sidekiq'
  mount Ckeditor::Engine => '/ckeditor'

  root to: 'web/welcome#index'

  get '/auth/:provider/callback' => 'web/omniauth#callback'
  get 'account' => 'web/users/account#index'
  get '/admin' => 'web/admin/welcome#index'

  scope module: :web do
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [ :index, :show ]
    resources :users, only: [ :new, :create ]
    resources :members, only: [ :new, :create ]
    resources :events, only: [ :show, :index ]
    resources :activity_lines, only: [:show]
    resources :articles, only: [ :index, :show ]
    resources :tags, only: [ :index, :show ]
    resources :projects, only: :show
    resources :remind_password, only: [ :new, :create ] do
      collection do
        get :edit
        patch :update
      end
    end
    get 'unsubscribe/:token' => 'subscriptions#destroy', as: :unsubscribe
    #resources :teams, only: [ :index, :show ]
    resource :page, only: [] do
      get '/:slug' => 'pages#show', as: :page
    end
    namespace :users do
      resources :account, only: :update
      resources :authentications, only: :destroy
      resources :positions, only: [ :create, :update, :destroy ]
      namespace :activity_lines do
        namespace :lider do
          namespace :ya_lider do
            resources :participant_events, only: [ :new, :create, :edit, :update ]
          end
        end
      end
    end
    namespace :members do
      namespace :corporative do
        resources :petitions, except: [ :index, :show, :destroy ]
      end
      resources :teams, only: [ :edit, :update ]
      resources :positions, except: [ :index, :show ]
    end
    namespace :activity_lines do
      namespace :corporative do
        resources :petitions, only: :index
        namespace :online_conferences do
          resources :questions, only: :create
        end
      end
      namespace :lider do
        resources :ya_liders, only: :show
        namespace :ya_lider do
          resources :stages, only: :show
        end
      end
    end
    namespace :admin do
      resources :users
      resources :members
      resources :unviewed, only: :index
      resources :news
      resources :articles
      resources :categories
      resources :activity_lines, except: [:show]
      resources :banners
      resources :feedbacks, except: [:show]
      resources :events
      resources :questionaries
      resources :teams, except: :show
      resources :tags, only: :create
      resources :documents, except: :show
      resources :comments, except: :show
      resources :letters, except: :show
      resources :positions, only: [ :update, :destroy ]
      resources :logged_actions, only: [ :index, :show ]
      resources :redirect_rules, except: :show
      resources :images, except: :show
      resources :tags, except: :show
      resources :test_papers
      resources :places
      resources :protocols
      resources :projects
      resources :videos
      resource :mine, only: :show
      resources :trash, only: [] do
        collection do
          get 'index/:type' => 'trash#index', as: :type
        end
        member do
          patch 'restore'
          delete 'destroy'
        end
      end
      namespace :activity_lines do
        namespace :corporative do
          resources :confessions
          resources :arguments, only: :destroy
          resources :online_conferences
          namespace :online_conference do
            resources :questions, except: :show
          end
          resources :merits, except: :show
        end
        namespace :lider do
          resources :ya_liders
          namespace :ya_lider do
            resources :stages, except: [ :index ]
            resources :participants
            resources :participant_fields, only: [ :new, :create, :show ]
            resources :participations, except: [ :index, :show, :new, :edit ]
          end
        end
      end
      namespace :delivery do
	resources :campaigns
        resources :audiences, only: [ :create, :destroy ]
	resources :sessions, only: [ :create, :destroy ]
        resources :contact_emails, only: [ :index, :update, :destroy ]
      end
      namespace :oauth do
        resources :apps
      end
      namespace :test_paper do
        resources :questions, except: [ :index, :show ]
      end
      namespace :protocol do
        resources :attenders, only: [ :create, :destroy ]
        resources :absents, only: [ :create, :destroy ]
      end
    end
    namespace :users do
      resources :account, only: :update
      resources :authentications, only: :destroy
      resources :attribute_accesses, only: :create
      resources :positions, only: [ :create, :update, :destroy ]
    end
    scope module: :users do
      resources :join, only: [ :new, :create ]
      resources :events, only: [ :show, :new, :create, :index ]
      resources :activity_lines, only: [:show]
    end
  end
  namespace :api do
    resources :news, only: :index
    resources :events, only: :index
    resources :feedbacks, only: :create
    resources :comments, only: [ :create, :destroy, :index ]
    resources :users, only: [] do
      member do
        get :confirm
        get :resent_email_instructions
      end
    end
    namespace :users do
      resources :votes, only: [ :create ] do
        collection do
          get :show
          patch :update
          delete :destroy
        end
      end
      namespace :account do
        resources :attribute_accesses, only: :create
        resources :subscriptions, only: [ :create ] do
          collection do
            delete :destroy
          end
        end
      end
      resources :places, only: [ :create, :index ]
    end
    namespace :events do
      resources :registrations, only: [ :create, :destroy, :update ]
    end
    namespace :admin do
      resources :places, only: [:create, :index]
      resources :members, only: :index
      resources :events, only: :index
      resources :activity_lines, only: :index
      resources :teams, only: :index
      resources :tags, only: [ :create, :destroy, :index ]
      resources :documents, only: :create
      namespace :event do
        resources :registrations, only: :create
      end
      namespace :delivery do
        resources :contact_emails, only: :create
      end
    end
    namespace :members do
      resources :members, only: :index
      namespace :corporative do
        resources :arguments, only: :create
      end
    end
    namespace :oauth do
      resources :users, only: :show
    end
    resources :yofications, only: [ :create, :update ]
    namespace :activity_lines do
      namespace :lider do
        resources :ya_liders, only: [ :show ]
        namespace :ya_lider do
          resources :participants, only: [ :create, :index ]
        end
      end
    end
  end
  namespace :rss do
    resources :news, only: :index
    resources :articles, only: :index
    resources :content, only: :index
    namespace :yandex do
      resources :news, only: :index
    end
  end

  namespace :xls do
    namespace :activity_lines do
      namespace :lider do
        namespace :ya_lider do
          resources :participants, only: :index
        end
      end
    end
  end

  scope module: :files do
    resources :images, only: [] do
      collection do
        get '/:slug' => 'images#show', as: :image
      end
    end
  end

  get '/:ticket' => 'web/members#show', constraints: { ticket: /\d*/ }, as: :member

  #FIXME  Not reacted for '/rails/mailers/user_mailer/after_create'
  #TODO Maybe add some checks for environment for this line? Like this?
  get '*unmatched_route', to: 'web/pages#show' if Rails.env == "production"
end
