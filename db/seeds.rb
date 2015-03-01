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
	'http://localhost',
	'https://localhost',
	'http://172.0.0.1',
	'https://172.0.0.1'
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

places = [
	'Oxoboxo River',
	'Lennon',
	'Magazine',
	'El Tumbao',
	'Dodgeville',
	'Science Hill',
	'Deerwood',
	'Howards Grove',
	'Lowden',
	'Grandyle Village',
	'Millcreek',
	'Deer Lodge',
	'Saronville',
	'Kingsland',
	'Meadowbrook Terrace',
	'Rothville',
	'Bruceton',
	'Cabazon',
	'Oketo',
	'Wilton Manors',
	'Bowie',
	'Grand Forks',
	'Alvordton',
	'Pilot Mound',
	'Emajagua'
]
places.each do |p|
	Place.create!(name: p)
end

users = [
	{email: 'user1@test.com', first_name: 'A-firstname', last_name: 'last', password: 'password', password_confirmation: 'password'},
	{email: 'user2@test.com', first_name: 'B-firstname', last_name: 'last', password: 'password', password_confirmation: 'password'},
	{email: 'user3@test.com', first_name: 'C-firstname', last_name: 'last', password: 'password', password_confirmation: 'password'},
	{email: 'user4@test.com', first_name: 'D-firstname', last_name: 'last', password: 'password', password_confirmation: 'password'},
	{email: 'user5@test.com', first_name: 'E-firstname', last_name: 'last', password: 'password', password_confirmation: 'password'}
]

tags = Tag.all
users.each do |u|
	user = User.create!(u)
	for i in 0..3
		lat = rand 55.00..68.00
		lng = rand 11.00..23.00
		pos = Position.create!(lat: lat.round(4), lng: lng.round(4))
		place = Place.offset(rand(Place.count)).first
		event = Event.create!(user_id: user.id, position_id: pos.id, place_id: place.id, comment: 'comment:' + user.first_name )
		
		tag_count = rand 0..4
		until tag_count <= 0 do
			tag = Tag.offset(rand(Tag.count)).first
			EventsTag.create(event_id: event.id, tag_id: tag.id)
			tag_count -= 1
		end
	end
end