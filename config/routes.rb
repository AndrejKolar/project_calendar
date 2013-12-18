ProjectCalendar::Application.routes.draw do
  resources :projects

  devise_for :users
  scope "/admin" do
    resources :users
  end

  resources :events

  get "calendar/index"
  get "calendar/show"

  get "reports/index"
  get "reports/:user_id", to: 'reports#get', as: 'reports_get'

  root 'calendar#index'
end
