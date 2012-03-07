# coding: UTF-8

require 'test_integration_helper'

class MessageIntegrationTest < ActionController::IntegrationTest

  should "be able to check his incoming messages" do
    sign_in_as("user1@gmail.com", "123456")

    visit '/messages/in'
    assert page.has_content?('Your Messages')

    sign_out
  end

  should "be able to check his outgoing messages" do
    sign_in_as("user1@gmail.com", "123456")

    visit '/messages/out'
    assert page.has_content?('Your Messages')

    sign_out
  end

end
