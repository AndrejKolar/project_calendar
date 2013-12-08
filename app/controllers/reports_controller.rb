class ReportsController < ApplicationController
  handles_sortable_columns

  def index
  end

  def get
    @beginning_current = params[:beginning_of_month].try(:to_date) || Date.current.beginning_of_month
    @date_range = (@beginning_current.beginning_of_month..@beginning_current.end_of_month)

    @beginning_next     = (@beginning_current + 1.month).beginning_of_month.to_s
    @beginning_previous = (@beginning_current - 1.month).beginning_of_month.to_s

    @current_time = Date.current
    @user = User.find(params[:user_id])
    @events = @user.events.order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])

    respond_to do |format|
      format.html # get.html.erb
      format.json { render json: @events }
    end
  end
end
