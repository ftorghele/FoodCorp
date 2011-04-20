# coding: UTF-8

require 'test_integration_helper'

class LoginIntegrationTest < ActionDispatch::IntegrationTest

  should "sign user in and out" do
    visit '/'
    sign_in_as("max.musterman@gmail.com", "123456")
    assert page.has_content?('Hans Testuser'), "login"

    sign_out
    assert page.has_content?('Signed out successfully'), "logout"
  end


end