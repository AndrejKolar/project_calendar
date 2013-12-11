module ProjectsHelper
  def users_for_project(project)
    user_id_array = project.events.pluck(:user_id)
    User.where(id: user_id_array)
  end
end
