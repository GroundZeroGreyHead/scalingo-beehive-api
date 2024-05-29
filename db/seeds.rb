# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Beehive.destroy_all

number_of_beehives = 100
beehives = []
number_of_beehives.times do
  beehives << { name: Faker::Lorem.characters(number: 8), weight: Faker::Number.between(from: 55.0, to: 150.0) }
end

beehives.each do |beehive_data|
  Beehive.create!(beehive_data)
end
