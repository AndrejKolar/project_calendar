ProjectCalendar::Application.routes.draw do
  get "welcome/index"
  get "dashboard/index"
  delete "dashboard/destroy"
  devise_for :users
  resources :events

  get "calendar/index"
  get "calendar/show"

  root 'welcome#index'
end
