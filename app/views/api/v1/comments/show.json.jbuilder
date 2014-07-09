json.comment do
  json.id    @comment.id
  json.title @comment.title
  json.name  @comment.name
  json.content @comment.content

  json.post_id @comment.post ? @comment.post.id : nil
end