Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "dashboard#index"

  # People management
  resources :people
  resources :students
  resources :teachers
  resources :deans

  # Academic resources
  resources :grades
  resources :examinations
  resources :courses
  resources :school_classes
  resources :subjects
  resources :promotion_asserts
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
