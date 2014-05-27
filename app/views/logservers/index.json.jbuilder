json.array!(@logservers) do |logserver|
  json.extract! logserver, :id, :hostname, :username
  json.url logserver_url(logserver, format: :json)
end
