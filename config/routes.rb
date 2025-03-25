Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'users/edit', to: 'users/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'users/registrations#update', as: 'user_registration'
    delete 'users', to: 'users/registrations#destroy'
  end

  concern :admin_accessible do
    member do
      post :create_user
    end
  end

  resources :people, concerns: :admin_accessible
  resources :students do
    member do
      patch :archive
    end
  end
  resources :teachers
  resources :deans
  resources :courses
  resources :subjects
  resources :promotion_asserts

  namespace :admin do
    root to: 'dashboard#index', as: :root
  end

  # Defines the root path route ("/")
  root "dashboard#index"

  # Academic resources
  resources :grades
  resources :examinations
  resources :school_classes
  resources :moments
  resources :sectors
  resources :statuses
  resources :rooms
  resources :addresses

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes (commented out)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

end
