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
  
  def getCategorieImageName(arg)
    array = ["icon_veggie.png", "icon_organic.png", "icon_kosher.png", "icon_asian.png", "icon_lactose-free.png", "icon_gluten-free.png", "icon_halal.png", "icon_hot.png", "icon_veryhot.png"]
    array[arg]
  end
  
  def rating_button_request(args)
   if Rating.find(:all, :conditions => { :user_id => args[:user_id] , :meal_id => args[:meal_id] }).count > 0
    return false;
   else
    return true;
   end
  end
  
  def get_number_of_guests meal_arrangments
    if meal_arrangments.empty?
      'no guests have ordered this meal yet.'
    else
      num = 0
      meal_arrangments.each do |arrang|
        if arrang.acceptance
          num += 1
        end
      end
      num.to_s << ' guests are invited.'
    end
  end
end
