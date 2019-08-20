Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :companies_pointers, only: [:new, :create, :destroy]
  end

  resources :companies, only: [:index, :show, :destroy]

  resources :users, only: [:show, :edit, :update]
end
