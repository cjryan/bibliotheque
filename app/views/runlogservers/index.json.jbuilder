json.array!(@runlogservers) do |runlogserver|
  json.extract! runlogserver, :id, :run_id, :logserver_id
  json.url runlogserver_url(runlogserver, format: :json)
end
