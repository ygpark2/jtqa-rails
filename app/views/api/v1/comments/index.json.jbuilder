json.comment @comments do |comment|
  json.id    comment.id
  json.title comment.title

  json.post_id  ? comment.post comment.post.id : nil
end