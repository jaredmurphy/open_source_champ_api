Rails.application.routes.draw do
    root to: "api_users#new"

    # auth
    get "/auth/:provider/callback" => "sessions#create"
    get "/signout" => "sessions#destroy", :as => :signout

    namespace :api do
      namespace :v1 do
        # players
        get '/players/', to: 'players#index'
        get '/players/:id', to: 'players#show'
        put '/players/:id', to: 'players#update'
        post '/players/', to: 'players#create'
        get '/search', to: 'players#search'

        #battles
        resources :battles, only: [:index, :show, :new, :create]
        get '/battles/lists/recent', to: 'battles#recent'
        get '/battles/lists/top', to: 'battles#top'
      end
    end
end
