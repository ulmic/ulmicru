require 'sidekiq/web'
# -*- coding: utf-8 -*-
Rails.application.routes.draw do
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
    #resources :teams, only: [ :index, :show ]
    resource :page, only: [] do
      get '/:slug' => 'pages#show', as: :page
    end
    namespace :users do
      resources :account, only: :update
      resources :authentications, only: :destroy
      resources :positions, only: [ :create, :update, :destroy ]
    end
    namespace :admin do
      resources :users, except: :show
      resources :members
      resources :unviewed, only: :index
      resources :news
      resources :articles
      resources :categories
      resources :activity_lines, except: [:show]
      resources :banners, except: [:show]
      resources :feedbacks, except: [:show]
      resources :events
      resources :questionaries
      resources :teams, except: :show
      resources :tags, only: :create
      resources :documents, except: :show
      resources :comments, except: :show
      resources :letters, except: :show
      resources :positions, only: [ :update, :destroy ]
      resources :trash, only: [] do
        collection do
          get 'index/:type' => 'trash#index', as: :type
        end
        member do
          patch 'restore'
          delete 'destroy'
        end
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
    resources :feedback, only: :create
    resources :comments, only: [ :create, :destroy ]
    resources :users, only: [] do
      member do
        get :confirm
        get :resent_email_instructions
      end
    end
    namespace :users do
      namespace :account do
        resources :attribute_accesses, only: :create
      end
    end
    namespace :events do
      resources :registrations, only: [ :create, :destroy ]
    end
    namespace :admin do
      resources :places, only: [:create] do
        collection do
          get ':place' => 'places#index', as: :index
        end
      end
      resources :members, only: :index
      resources :events, only: :index
      resources :activity_lines, only: :index
      resources :teams, only: :index
      resources :tags, only: [ :create, :destroy, :index ]
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
  get '/:ticket' => 'web/members#show', constraints: { ticket: /\d*/ }, as: :member
  
  #FIXME  Not reacted for '/rails/mailers/user_mailer/after_create' 
  #TODO Maybe add some checks for environment for this line? Like this?
  get '*unmatched_route', to: 'web/pages#show', slug: :not_found if Rails.env == "production"
end
