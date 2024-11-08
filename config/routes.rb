Rails.application.routes.draw do
  devise_for :users, path: "", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  resources :posts do
    member do
     get :toggle_status
    end
  end
  resources :portfolios, except: [ :show ]

  get "portfolio/:id", to: "portfolios#show", as: "portfolio_show"

  get "about-me", to: "pages#about"
  get "contact",  to: "pages#contact"
  resources :guides

  root to: "pages#home"

  get "comments", to: "comments#info"

  get "comments/show", to: "comments#show"
  resources :user

  get "users", to: "users#index"

  resources :teachers do
    resources :courses
  end

  resources :students do
    resources :enrollments
  end

  resources :courses do
    resources :feedbacks
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  #
end
