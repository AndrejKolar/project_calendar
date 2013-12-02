ProjectCalendar::Application.routes.draw do
  get "dashboard/index"
  devise_for :users
  resources :events

  get "calendar/index"

  root 'calendar#index'
end
