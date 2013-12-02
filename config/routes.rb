ProjectCalendar::Application.routes.draw do
  get "dashboard/index"
  devise_for :users
  resources :events

  get "calendar/index", as: 'calendar'

  root 'calendar#index'
end
