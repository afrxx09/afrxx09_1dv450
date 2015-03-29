# ruby encoding: utf-8

api_admin = ApiUser.create!(first_name:  'Admin',
	last_name: 'Adminsson',
	email: 'admin@test.com',
	password: 'password',
	password_confirmation: 'password',
	admin: true)

api_user = ApiUser.create!(first_name:  'User',
	last_name: 'Tester',
	email: 'user@test.com',
	password: 'password',
	password_confirmation: 'password',
	admin: false)

app = ApiApplication.create!(name: 'Test Application',
    description: 'Description of test application',
    api_user_id: api_user.id)

api_key = ApiKey.create!(key: '524c94faf385b814ce22d7d83b73cbd3', api_application_id: app.id)

app_urls = [
	'localhost',
	'172.0.0.1'
]

app_urls.each do |u|
	AppUrl.create!(url: u, api_application_id: app.id);
end




tags = [
	'Uniramous',
	'Comprehendible',
	'Pineweed',
	'Track',
	'Sparve',
	'Simpler',
	'Launch',
	'Celandine',
	'Merciless',
	'Dower'
]
tags.each do |t|
	Tag.create!(tag: t)
end

Place.create!(google_place_id: 'ChIJZYhcYUoyUkYRe3ieF7EnGMo', name: 'Evil Twins Heavenly Tattoo Studio', lng: 12.698149999999941, lat:56.045162);
Place.create!(google_place_id: 'ChIJCf-iLY0jV0YR8esLkZY8ZAc', name: 'Old Sailor Tattoo', lng: 14.805115999999998, lat: 56.87973);
Place.create!(google_place_id: 'ChIJFWzJKfMjV0YRjvUHCcN2W9M', name: 'Wild Tattoo Art', lng: 14.803744000000052, lat:56.877809);
Place.create!(google_place_id: 'ChIJv0oCCWXRV0YRcuBOJ7ksDFw', name: 'Black Diamond Tattoo AB', lng: 16.363990000000058, lat:56.665348);
Place.create!(google_place_id: 'ChIJl-iAhWTRV0YRBhEZtnooyv4', name: 'Diegos Tattoo AB', lng: 16.36170100000004, lat:56.662568);

users = [
	{email: 'user1@test.com', first_name: 'Anna', last_name: 'Andersson', password: 'password', password_confirmation: 'password'},
	{email: 'user2@test.com', first_name: 'Bertil', last_name: 'Bokmal', password: 'password', password_confirmation: 'password'},
	{email: 'user3@test.com', first_name: 'Claus', last_name: 'Carpenter', password: 'password', password_confirmation: 'password'},
	{email: 'user4@test.com', first_name: 'Diana', last_name: 'Daniels', password: 'password', password_confirmation: 'password'},
	{email: 'user5@test.com', first_name: 'Edmund', last_name: 'El pollo loco', password: 'password', password_confirmation: 'password'}
]

tags = Tag.all
users.each do |u|
	user = User.create!(u)
	for i in 0..3
		place = Place.offset(rand(Place.count)).first
		pos = Position.create!(lat: place.lat.round(5), lng: place.lng.round(5))
		event = Event.create!(user_id: user.id, position_id: pos.id, place_id: place.id, comment: 'My comment on: ' + place.name )
		
		tag_count = rand 0..4
		until tag_count <= 0 do
			tag = Tag.offset(rand(Tag.count)).first
			EventsTag.create(event_id: event.id, tag_id: tag.id)
			tag_count -= 1
		end
	end
end