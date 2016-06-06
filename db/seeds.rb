# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "forlax", email: "forlax@mail.com", password: "forlax")
User.first.update_attributes(role: 1)
User.create!(name: "tranee", email: "tranee@mail.com", password: "tranee")
