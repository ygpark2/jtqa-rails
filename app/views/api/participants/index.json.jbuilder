json.participant @participants do |album|
  json.id    participant.id
  json.title participant.title

  json.artist_id participant.artist ? participant.artist.id : nil
end