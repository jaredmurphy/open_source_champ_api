Rails.application.routes.draw do
    root to: "api_users#new"
    get "/auth/:provider/callback" => "sessions#create"
    get "/signout" => "sessions#destroy", :as => :signout

    namespace :api do
      namespace :v1 do
        get '/players/:login', to: 'players#show'
        post '/players/', to: 'players#create'
        resources :battles, only: [:index, :show, :new, :create]
      end
    end
end
