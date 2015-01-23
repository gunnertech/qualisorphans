json.array!(@posts) do |post|
  json.extract! post, :id, :tweet_id_str, :body, :photo_url, :tweet_created_at
  json.url post_url(post, format: :json)
end
