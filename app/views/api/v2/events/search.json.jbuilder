json.events @events do |event|
	json.id event.id
	json.url api_v2_event_url(event)
	json.comment event.comment
	json.user do
		json.id event.user.id
		json.email event.user.email
		json.first_name event.user.first_name
		json.last_name event.user.last_name
		json.url api_v2_user_url(event.user)
	end
	
	if event.place
		json.place do
			json.id event.place.id
			json.name event.place.name
			json.address event.place.address
			json.city event.place.city
			json.zip event.place.zip
			json.url api_v2_place_url(event.place)
		end
	else
		json.place nil
	end
	
	json.position do
		json.id event.position.id
		json.lat event.position.lat
		json.lng event.position.lng
		json.url api_v2_position_url(event.position)
	end
	
	json.tags event.tags do |tag|
		json.id tag.id
		json.tag tag.tag
		json.url api_v2_tag_url(tag)
	end
	
end