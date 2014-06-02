json.array!(@brokertypes) do |brokertype|
  json.extract! brokertype, :id, :name
  json.url brokertype_url(brokertype, format: :json)
end
