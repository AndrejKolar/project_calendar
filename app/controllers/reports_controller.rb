class ReportsController < ApplicationController
  def index
  end

  def get
    @user = User.find(params[:user_id])
  end
end
