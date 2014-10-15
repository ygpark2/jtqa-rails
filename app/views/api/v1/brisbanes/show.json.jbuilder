json.brisbane do
  json.id                  @brisbane.id
  json.category            @brisbane.category
  json.user_id             @brisbane.user_id
  json.title               @brisbane.title
  json.name                @brisbane.name
  json.views               @brisbane.views
  json.email               @brisbane.email
  json.phone               @brisbane.phone
  json.tags                @brisbane.tags do |tag|
    json.id             tag.id
    json.name           tag.name
    json.taggings_count tag.taggings_count
    json.posts               do
      json.array! [{:id => @brisbane.id, :type => "brisbane"}]
    end
  end
  json.links do
    json.comments "/api/v1/brisbanes/#{@brisbane.id}/comments"
  end
  json.content             @brisbane.content
  json.total_comments      @brisbane.total_comments
  json.created_at          @brisbane.created_at
  json.updated_at          @brisbane.updated_at

end
