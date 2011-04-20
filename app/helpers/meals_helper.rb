module MealsHelper
  
  def button_request(args)
    if MealArrangement.find(:all, :conditions => { :user_id => args[:user_id] , :meal_id => args[:meal_id] }).count > 0 
     return false;
    else
     return true;
    end
  end
  
end
