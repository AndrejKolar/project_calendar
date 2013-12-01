class CalendarController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.admin?
      redirect_to :controller=>'dashboard', :action => 'index'
    end
  end
end
