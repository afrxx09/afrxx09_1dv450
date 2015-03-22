json.places @places do |place|
	json.id place.id
	json.name place.name
	json.address place.address
	json.city place.city
	json.zip place.zip
end

if @places.count == @limit
	json.next api_v2_places_url(offset: @next_offset, limit: @limit)
end

if @offset > 0	
	json.prev api_v2_places_url(offset: @prev_offset, limit: @limit)
end