# -*- coding: utf-8 -*-
Rails.application.routes.draw do
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
    resources :teams, only: [ :index, :show ]
    resource :page, only: [] do
      get '/:slug' => 'pages#show', as: :page
    end
    namespace :users do
      resources :account, only: :update
      resources :authentications, only: :destroy
      resources :positions, only: [ :create, :update, :destroy ]
    end
    namespace :admin do
      resources :users
      resources :members
      resources :unviewed, only: :index
      resources :news
      resources :articles
      resources :categories
      resources :activity_lines, except: [:show]
      resources :banners, except: [:show]
      resources :events
      resources :questionaries
      resources :teams, except: :show
      resources :tags, only: :create
      resources :documents, except: :show
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
    namespace :users do
      namespace :account do
        resources :attribute_accesses, only: :create
      end
    end
    namespace :events do
      resources :registrations, only: [ :create, :destroy ]
    end
    namespace :admin do
      resources :places, only: [] do
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
  get '/:ticket' => 'web/members#show', constraints: { ticket: /\d*/ }, as: :member
end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
