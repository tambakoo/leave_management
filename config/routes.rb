Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {:registrations => "registrations"}
  root 'leaves#index'
  resources :leaves
  resources :leave_records
  resources :salaries
  get '/employee_records', to: 'leaves#employee_records'
  get '/help', to: 'application#help'
  get '/structure', to: 'application#tree'
end
