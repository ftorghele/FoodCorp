class Message < ActiveRecord::Base
  attr_accessible :receiver, :topic, :body
end
