class CalendarController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    session[:selected_user_id] = params[:user]
  end
end
