ProjectCalendar::Application.routes.draw do
  devise_for :users
  resources :events

  get "calendar/index"

  root 'calendar#index'
end
