ProjectCalendar::Application.routes.draw do
  get "welcome/index"

  devise_for :users
  scope "/admin" do
    resources :users
  end

  resources :events

  get "calendar/index"
  get "calendar/show"

  root 'welcome#index'
end
