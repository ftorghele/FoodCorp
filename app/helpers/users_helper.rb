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

  def find_meal(args)
    return Meal.find(args[:meal_id])
  end

end
