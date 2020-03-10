Rails.application.routes.draw do
  root 'pages#home'
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :create]
    end
  end
  match '*path', to: 'pages#home', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
