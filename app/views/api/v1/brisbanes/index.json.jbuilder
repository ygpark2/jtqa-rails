json.brisbanes @brisbanes do |post|
  json.id                  post.id
  json.category            post.category
  json.user_id             post.user_id
  json.title               post.title
  json.name                post.name
  json.views               post.views
  json.email               post.email
  json.phone               post.phone
  json.tags                post.tags do |tag|
    json.id  tag.id
    json.name tag.name
    json.taggins_count tag.taggings_count
    json.posts [ post.id ]
  end
  json.content             post.content
  json.total_comments      post.total_comments
  json.created_at          post.created_at
  json.updated_at          post.updated_at

end
