# coding: UTF-8

require 'test_helper'

class PageIntegrationTest < ActionDispatch::IntegrationTest

  def check_content args
    args.each do |content|
        assert page.has_content?(content)
    end
  end

  def check_design args
    args.each do |design|
        assert page.has_css?(design, :count => 1)
    end
  end

  should "show home page correct" do
    visit '/'
    #checking the html structure
    check_design ['div#meals_distance_stream','div#map', 'a#fb_sign_in' ]
  end

  should "show static pages correct" do
    visit '/'
    click_on("About")
    check_design ['div#main_body','div#main_header']
    check_content ['About DinnerCollective']
    
    click_on("Imprint")
    check_design ['div#main_body','div#main_header']
    check_content ['Imprint']
    
    click_on("Terms of service")
    check_design ['div#main_body','div#main_header']
    check_content ["Terms of Service"]
  end
  
end
