module ApplicationHelper

  def is_this_user?(reserve)
    reserve.user.id == current_user.id
  end
end
