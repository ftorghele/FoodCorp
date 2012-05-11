module MealsHelper

  def button_request(args)
    if MealArrangement.find(:all, :conditions => { :user_id => args[:user_id] , :meal_id => args[:meal_id] }).count > 0
     return false;
    else
     return true;
    end
  end

  def user_name(args)
    firstname = User.find(args[:id]).first_name
    lastname = User.find(args[:id]).last_name
    name = firstname + " " + lastname
    return name
  end
  
  def getCategorieImageName(args)
    array = Array.new("icon_veggi.png", "icon_organic.png", "icon_kosher.png", "icon_asian.png", "icon_lactose-free.png", "icon_gluten-free.png", "icon_halal.png")
    array[args]
  end
  
end
