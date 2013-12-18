class CalendarController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:selected_user_id] = current_user.id
  end

  def show
    if current_user.admin?
      session[:selected_user_id] = params[:user]
    else
      session[:selected_user_id] = current_user.id
    end
  end
end
