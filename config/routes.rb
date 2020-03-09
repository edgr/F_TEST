Rails.application.routes.draw do
  root 'pages#home'
  match '*path', to: 'pages#home', via: :all
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
