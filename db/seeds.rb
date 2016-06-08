# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "manhnh", email: "manhnh@mail.com", password: "123456789")
User.first.update_attributes(role: 1)
User.create!(name: "tranee", email: "tranee@mail.com", password: "tranee")
arr = Array(1..100)
arr.each do |i|
	User.create!(name: "examples" + i.to_s, email: "examples" + i.to_s + "@mail.com", password: "123456789")
end
