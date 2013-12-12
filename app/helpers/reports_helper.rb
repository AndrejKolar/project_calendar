module ReportsHelper
  def time_for_project(project, user, span)
    Event.where(starts_at: span, user: user, project: project).sum(:total_hours)
  end
end
