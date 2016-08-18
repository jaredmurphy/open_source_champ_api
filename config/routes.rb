Rails.application.routes.draw do
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :players, only: [:index, :show, :new, :create, :edit, :update]
        resources :battles, only: [:index, :show, :new, :create]
      end
    end
  end
end
