# coding: UTF-8

require 'test_helper'

class PageIntegrationTest < ActionDispatch::IntegrationTest
  should "show home page correct" do
    visit '/'
    #checking the html structure
    assert page.has_css?('a#fb_sign_in', :count => 1)
    #assert page.has_css?('iframe#fb_like_button', :count => 1)
    assert page.has_css?('div#map', :count => 1)
    assert page.has_css?('div#meals_distance_stream', :count => 1)
  end

  should "show static pages correct" do
    visit '/'
    click_on("About")
    assert page.has_css?('div#about', :count => 1)
    assert page.has_content?('About FoodCorp')
    
    click_on("Imprint")
    assert page.has_css?('div#imprint', :count => 1)
    assert page.has_content?('Web programming:')
    
    click_on("Terms of service")
    assert page.has_css?('div#terms_of_service', :count => 1)
    assert page.has_content?('Using FoodCorp')
  end
  
end
