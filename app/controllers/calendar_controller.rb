class CalendarController < ApplicationController
  before_filter :authenticate_user!

  def index
    p "Calendar params = " + params.to_s
  end

  def show
    p "Calendar params show = " + params.to_s
  end
end
