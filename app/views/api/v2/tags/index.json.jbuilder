json.tags @tags do |tag|
	json.id tag.id
	json.tag tag.tag
	json.url api_v2_tag_url(tag)
end

if @tags.count == @limit
	json.next api_v2_tags_url(offset: @next_offset, limit: @limit)
end

if @offset > 0
	json.prev api_v2_tags_url(offset: @prev_offset, limit: @limit)
end
