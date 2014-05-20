json.array!(@brokertypes) do |brokertype|
  json.extract! brokertype, :id, :brokertype
  json.url brokertype_url(brokertype, format: :json)
end
