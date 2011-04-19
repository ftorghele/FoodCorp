module ApplicationHelper
  def get_avatar_url(user)
    if user.use_fb_avatar
      return "http://graph.facebook.com/" + user.fb_id.to_s + "/picture?type=large"
    else
      return user.avatar.url(:medium)
    end
  end
end
