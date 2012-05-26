FactoryGirl.define do
  factory :user do
    first_name "Mr.Test"
    last_name  "Test"
    gender "male"
    password "geheim"
    email "mr.test@test.com"
    #admin false
  end
end
