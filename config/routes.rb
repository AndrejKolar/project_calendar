ProjectCalendar::Application.routes.draw do
  get "welcome/index"

  devise_for :users
  scope "/admin" do
    resources :users
  end

  resources :events

  get "calendar/index"
  get "calendar/show"

  get "reports/index"
  get "reports/:user_id", to: 'reports#get', as: 'reports_get'

  root 'welcome#index'
end
