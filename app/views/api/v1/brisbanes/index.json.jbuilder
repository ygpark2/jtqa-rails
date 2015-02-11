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
    json.id                  tag.id
    json.name                tag.name
    json.taggings_count      tag.taggings_count
    json.posts               do 
      json.array! [{:id => post.id, :type => "brisbane"}]
    end
  end
  json.comments            post.comments do |comment|
    json.id                  comment.id
    json.brisbane            post.id
    json.title               comment.title
    json.comment             comment.comment
  end
  json.content             post.content
  json.total_comments      post.total_comments
  json.created_at          post.created_at
  json.updated_at          post.updated_at

end

json.set! :meta do
  json.set! :total_pages, @brisbanes.total_pages
end
