class ReportsController < ApplicationController
  handles_sortable_columns

  def index
  end

  def get
    @user = User.find(params[:user_id])

    # date ranges
    @beginning_current = params[:beginning_of_month].try(:to_date) || Date.current.beginning_of_month
    @date_range = (@beginning_current.beginning_of_month..@beginning_current.end_of_month)
    @beginning_next = (@beginning_current + 1.month).beginning_of_month.to_s
    @beginning_previous = (@beginning_current - 1.month).beginning_of_month.to_s

    # get events
    @events = @user.events.where(starts_at: @date_range)
    @events = @events.order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @events.to_csv }
      format.xls
    end
  end
end
