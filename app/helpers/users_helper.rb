module UsersHelper
  def get_following(args)
    return Fellowship.find(:first, :conditions => { :user_id => current_user.id, :follower_id => args[:user].id } )
  end

  def is_following(current_user, user)
    if (current_user && Fellowship.where(:user_id => current_user.id, :follower_id => user.id ).count > 0)
     return true
    else
      return false
    end
  end

  def get_user_name(args)
    return User.find(args)
  end

  def comment_admit(args)
    if MealArrangement.where("acceptance = 1 AND user_id = ? AND meal_id = ? ", current_user.id, args ).count > 0
      return true
    else
      return false
    end
  end

end
