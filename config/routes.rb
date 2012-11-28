QpomPretest::Application.routes.draw do

  devise_for :admins, controllers: { 
    sessions: "admins/sessions", 
    registrations: "admins/registrations"
  }, path_names: {
    sign_in: 'login',
    sign_up: 'register'
  } do 
    get "/admins/logout" => "admins/sessions#destroy", :as => :destroy_admin_session
  end


  get "admin/userlist"

  get "admin/shoplist"

  get "admin/couponlist"

  get "admin/shop"

  devise_for :shops, path_names: {
    sign_in: 'login',
    sign_up: 'register'
  } do 
    get "/shops/logout" => "devise/sessions#destroy", :as => :destroy_shop_session
  end

  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: 'coupons#top'

  resources :users

  match 'coupons/ranking' => 'coupons#ranking'

  match 'coupons/my' => 'coupons#my'

  resources :shops do
    collection do
      get 'my'
      get 'search'
      get 'find'
    end
    member do
      post 'add_to_my'
      post 'remove_from_my'
    end
    resources :coupons do
      member do
        post 'use'
        post 'get'
      end
      collection do
        get 'show_new'
        get 'share'
      end
    end
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  match 'prefectures' => 'location#prefectures'
  match 'towns' => 'location#towns'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # This route can be invoked with purchase_url(id: product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root to: 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
