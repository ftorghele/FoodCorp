module ApplicationHelper
  def get_medium_avatar_url(user)
    if user.use_fb_avatar
      return "http://graph.facebook.com/" + user.fb_id.to_s + "/picture?type=large"
    else
      return user.avatar.url(:medium)
    end
  end

  def get_thumb_avatar_url(user)
    if user.use_fb_avatar
      return "http://graph.facebook.com/" + user.fb_id.to_s + "/picture"
    else
      return user.avatar.url(:thumb)
    end
  end
  
  def convert
  end
end
