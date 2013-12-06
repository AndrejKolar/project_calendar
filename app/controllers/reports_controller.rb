class ReportsController < ApplicationController
  handles_sortable_columns

  def index
  end

  def get
    # User.search(params[:search]).order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])
    @user = User.find(params[:user_id])
    @events = @user.events.order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])
  end
end
