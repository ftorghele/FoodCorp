# test/blueprints.rb
require 'machinist/active_record'
require 'sham'
require 'faker'

# set locale of faker, otherwise we would be using the default locale
Faker::Config.locale = :en

# Jeder Task soll einen eigenen Title bekommen
Sham.title  { Faker::Name.name }

Task.blueprint do
  title { Sham.title }
  estimated_length 3
  # oder bei Namensgleichheit zwischen Sham und Attribut einfach:
  # title
end
