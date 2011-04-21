module MessagesHelper
  def get_username_by_id(id)
    user = User.find(id)
    return user.first_name + " " + user.last_name
  end
end
