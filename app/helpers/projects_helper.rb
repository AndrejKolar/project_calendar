module ProjectsHelper
  def users_for_project(project)
    user_id_array = project.events.pluck(:user_id)
    User.where(id: user_id_array)
  end

  def total_time_for_project(project)
    project.events.sum(:total_hours)
  end

  def current_month_time_for_project(project)
    date_range = (Date.current.beginning_of_month..Date.current.end_of_month)
    project.events.where(starts_at: date_range).sum(:total_hours)
  end
end
