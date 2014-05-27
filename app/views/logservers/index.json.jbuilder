json.array!(@logservers) do |logserver|
  json.extract! logserver, :id, :ip, :hostname
  json.url logserver_url(logserver, format: :json)
end
