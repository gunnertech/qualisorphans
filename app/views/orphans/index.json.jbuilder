json.array!(@orphans) do |orphan|
  json.extract! orphan, :id, :first_name, :last_name
  json.url orphan_url(orphan, format: :json)
end
