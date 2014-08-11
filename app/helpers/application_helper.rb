module ApplicationHelper
  def username(id)
    user=User.find(id)
    user.username
  end
end
