json.array!(@logservers) do |logserver|
  json.extract! logserver, :id, :hostname
  json.url logserver_url(logserver, format: :json)
end
