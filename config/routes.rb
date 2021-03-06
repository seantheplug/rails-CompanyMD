Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get 'uikit', to: 'pages#uikit'
  get 'search', to: 'pages#search'
  get 'home', to: 'pages#home'
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
    resources :sec_data_fetches, only: [:index]
    get 'charts/show/intraday', to: 'charts#completed_company_show_intraday_tasks'
    get 'charts/show/daily/one_month', to: 'charts#completed_company_show_daily_one_month_tasks'
    get 'charts/show/daily/six_month', to: 'charts#completed_company_show_daily_six_month_tasks'
    get 'charts/show/daily/one_year', to: 'charts#completed_company_show_daily_one_year_tasks'
    get 'charts/show/weekly', to: 'charts#completed_company_show_weekly_tasks'
    get 'charts/index', to: 'charts#completed_company_index_tasks'
  end

  # get 'charts/show', :to => 'charts#completed_company_chart_tasks'
end
