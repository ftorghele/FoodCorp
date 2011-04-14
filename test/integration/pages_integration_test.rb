require 'test_helper'

class PageIntegrationTest < ActionDispatch::IntegrationTest
  should "show page" do
    visit '/'
    # checking the html structure
    assert page.has_css?('a#fb_sign_in', :count => 1)
    click_button "About"
    assert page.has_css?('div#about', :count => 1)
    assert page.has_content?('Food Corp user agreement')
    #...
  end
end
