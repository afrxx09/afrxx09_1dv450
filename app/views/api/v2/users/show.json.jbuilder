json.id @user.id
json.email @user.email
json.first_name @user.first_name
json.last_name @user.last_name
json.url api_v2_user_url(@user)

json.events @user.events do |event|
	json.id event.id
	json.comment event.comment
	
	json.url api_v2_event_url(event)
end	