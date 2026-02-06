Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: "users/registrations"
  }

  authenticated :user do
    root "dashboards#show", as: :authenticated_root
  end

  unauthenticated do
    root "events#index"
  end

  resource :dashboard, only: [ :show ]
  resources :users, only: [ :index, :show ], controller: "users"
  resources :events do
    resources :enrollments, only: [ :create, :destroy ]
  end

  get "/about", to: "home#about", as: :about
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
