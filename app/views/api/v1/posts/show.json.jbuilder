json.post do
  json.id    @post.id
  json.title @post.title
  json.name  @post.name
  json.content @post.content

end