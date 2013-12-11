class CalendarController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:selected_user_id] = current_user.id
  end

  def show
    session[:selected_user_id] = params[:user]
  end
end
