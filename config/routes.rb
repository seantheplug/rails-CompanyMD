Rails.application.routes.draw do

  devise_for :users
  root to: 'companies#index'
  get 'uikit', to: 'pages#uikit'
  get 'search', to: 'pages#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update]

  resources :groups do
    resources :companies_pointers, only: [:destroy]
  end

  # resources :companies_pointers, only: [:new, :create]

  resources :companies, only: [:index, :show, :destroy] do
    resources :companies_pointers, only: [:new, :create]
    resources :news, only: [:index]
    resources :financial, only: [:show]
    get 'charts/show/daily', to: 'charts#completed_company_show_daily_tasks'
    get 'charts/index', to: 'charts#completed_company_index_tasks'
  end

  # get 'charts/show', :to => 'charts#completed_company_chart_tasks'
end
