# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ApiUser.create!(first_name:  'Admin',
	last_name: 'Adminsson',
	email: 'admin@test.com',
	password: 'password',
	password_confirmation: 'password',
	admin: true)
ApiUser.create!(first_name:  'User',
	last_name: 'Tester',
	email: 'user@test.com',
	password: 'password',
	password_confirmation: 'password',
	admin: false)