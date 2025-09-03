Rails.application.routes.draw do
  root to: "signups#new"

  # Authenticated app shell via token query param (?token=...)
  get "/search",    to: "search#index",          as: :search
  get "/register",  to: "register#index",        as: :register
  get "/borrowing", to: "borrowing#index",       as: :borrowing
  get "/lending",   to: "lending#index",         as: :lending
  get "/admin",     to: "admin/account#show",    as: :admin_root
  post "/admin/regenerate", to: "admin/account#regenerate", as: :admin_regenerate

  get "/signup", to: "signups#new", as: :signup
  post "/signup", to: "signups#create"

  # No session-based auth routes; magic token via query param only

  # Remove global admin routes; admin lives under token scope
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
