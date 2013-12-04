module UsersHelper
  def not_this_user?(user)
    if user.id != current_user.id
      true
    else
      false
    end
  end
end
