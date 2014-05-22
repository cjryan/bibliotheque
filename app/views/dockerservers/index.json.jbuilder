json.array!(@dockerservers) do |dockerserver|
  json.extract! dockerserver, :id, :url
  json.url dockerserver_url(dockerserver, format: :json)
end
