Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :players, only: [:index, :show, :new, :create, :edit, :update]
        resources :battles, only: [:index, :show, :new, :create]
      end
    end
end
