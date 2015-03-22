json.users @users do |user|
	json.id user.id
	json.email user.email
	json.first_name user.first_name
	json.last_name user.last_name
	json.url api_v2_user_url(user)
	
	json.events user.events do |event|
		json.id = event.id
		json.comment event.comment
		
		json.url api_v2_event_url(event)
	end
	
end

if @users.count == @limit
	json.next api_v2_users_url(offset: @next_offset, limit: @limit)
end

if @offset > 0
	json.prev api_v2_users_url(offset: @prev_offset, limit: @limit)
end