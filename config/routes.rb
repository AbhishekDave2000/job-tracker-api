Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do

      # Auth
      post "auth/register", to: "authentication#register"
      post "auth/login",    to: "authentication#login"
    
      # Job Applications
      resources :job_applications

      # Contacts of particular Application
      resources :contacts

      # Follow Up routes
      resources :follow_ups
      post "complete_follow_up/:id", to: "follow_ups#complete_follow_up"
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
