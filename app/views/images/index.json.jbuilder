json.array!(@images) do |image|
  json.extract! image, :id, :uuid, :tag, :dockerserver_id
  json.url image_url(image, format: :json)
end
