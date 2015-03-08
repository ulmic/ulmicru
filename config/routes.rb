# -*- coding: utf-8 -*-
Rails.application.routes.draw do
  root to: 'web/welcome#index'

  get '/auth/:provider/callback' => 'web/omniauth#callback'
  get 'account' => 'web/users/account#index'

  scope module: :web do
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [:index, :show]
    resources :users, only: [ :new, :create ]
    resources :members, only: [ :new, :create ] do
      collection do
        get '/:ticket' => 'members#show'
      end
    end
    resources :join, only: [ :new, :create ]
    namespace :users do
      resources :account, only: [ :update ]
    end
    namespace :admin do
      root to: 'welcome#index'
      resources :users
      resources :members
      resources :unviewed, only: :index
      resources :news
      resources :trash, only: [] do
        collection do
          get 'index/:type' => 'trash#index', as: :type
        end
        member do
          patch 'restore'
          delete 'destroy'
        end
      end
      resources :join
    end
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
end
