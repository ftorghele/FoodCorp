# test/blueprints.rb
require 'machinist/active_record'
require 'sham'
require 'faker'

# set locale of faker, otherwise we would be using the default locale
Faker::Config.locale = :en

# Jedes Meal soll einen eigenen Title bekommen
Sham.title  { Faker::Name.name }

Meal.blueprint do
  title { Sham.title }

  # oder bei Namensgleichheit zwischen Sham und Attribut einfach:
  # title
end
