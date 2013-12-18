class ReportsController < ApplicationController
  handles_sortable_columns

  def get
    if current_user && current_user.admin?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    # date ranges
    @beginning_current = params[:beginning_of_month].try(:to_date) || Date.current.beginning_of_month
    @date_range = (@beginning_current.beginning_of_month..@beginning_current.end_of_month)
    @beginning_next = (@beginning_current + 1.month).beginning_of_month.to_s
    @beginning_previous = (@beginning_current - 1.month).beginning_of_month.to_s

    # events
    @events = @user.events.where(starts_at: @date_range).search(params[:search])
    @events = @events.order(sortable_column_order).paginate(:per_page => 50, :page => params[:page])

    # time
    @total_time = @events.sum(:total_hours)

    # projects
    project_ids = @events.pluck(:project_id)
    @projects = Project.where(id: project_ids)

    filename = 'Report for ' + @user.name

    respond_to do |format|
      format.html
      format.csv { send_data @events.to_csv, filename:  filename + '.csv'}
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{filename}.xls\"" }
    end
  end
end
