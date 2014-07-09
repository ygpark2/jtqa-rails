json.post @posts do |post|
  json.id    post.id
  json.title post.title
  json.name post.name
  json.views post.views
  json.created_at post.created_at

end