json.array!(@rhcbranches) do |rhcbranch|
  json.extract! rhcbranch, :id, :name
  json.url rhcbranch_url(rhcbranch, format: :json)
end
