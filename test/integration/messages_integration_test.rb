# coding: UTF-8

require 'test_integration_helper'

class MessageIntegrationTest < ActionController::IntegrationTest

  should "be able to check his messages" do
    sign_in_as("user1@gmail.com", "123456")

    visit '/messages'

    sign_out
  end

end
