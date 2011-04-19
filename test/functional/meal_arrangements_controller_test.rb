require 'test_helper'

class MealArrangementsControllerTest < ActionController::TestCase
  setup do
    @meal_arrangement = meal_arrangements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meal_arrangements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meal_arrangement" do
    assert_difference('MealArrangement.count') do
      post :create, :meal_arrangement => @meal_arrangement.attributes
    end

    assert_redirected_to meal_arrangement_path(assigns(:meal_arrangement))
  end

  test "should show meal_arrangement" do
    get :show, :id => @meal_arrangement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @meal_arrangement.to_param
    assert_response :success
  end

  test "should update meal_arrangement" do
    put :update, :id => @meal_arrangement.to_param, :meal_arrangement => @meal_arrangement.attributes
    assert_redirected_to meal_arrangement_path(assigns(:meal_arrangement))
  end

  test "should destroy meal_arrangement" do
    assert_difference('MealArrangement.count', -1) do
      delete :destroy, :id => @meal_arrangement.to_param
    end

    assert_redirected_to meal_arrangements_path
  end
end
