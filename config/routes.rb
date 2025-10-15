Rails.application.routes.draw do
  get "output_sheets/new"
  get "output_sheets/create"
  get "output_sheets/show"
  get "output_sheets/edit"
  get "output_sheets/update"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "dashboard#index"

  #Rutas para el recurso workshop
  resources :clients
  resources :workshops
  resources :motorcycles do
    member do
      post 'create_intervention'
    end
  end

  resources :interventions do
    resources :entry_orders, only: [:new, :create, :show, :edit, :update]
    resources :procedure_sheets, only: [:new, :create, :show, :edit, :update]
    resources :output_sheets, only: [:new, :create, :show, :edit, :update]
  end

end
