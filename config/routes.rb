Rails.application.routes.draw do
  namespace :public do
    resources :interventions, only: [:show], param: :token

    # --- REEMPLAZA LAS RUTAS ANTERIORES POR ESTAS ---
    # 1. Ruta para MOSTRAR el formulario de búsqueda.
    get 'motorcycle_history/search', to: 'motorcycles#search', as: :motorcycle_history_search
    # 2. Ruta para PROCESAR la búsqueda y mostrar el resultado.
    get 'motorcycle_history/result', to: 'motorcycles#result', as: :motorcycle_history_result
  end
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
  
  resources :workshops do
    resources :mechanics
  end

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

  resources :plans do
    resources :subscriptions, only: [:new, :create]
  end

  # Ruta para que los usuarios vean su suscripción
  resources :subscriptions, only: [:index, :show] do
    member do
      patch :approve
    end
  end


  resources :conversations, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create], shallow: true
  end

end
