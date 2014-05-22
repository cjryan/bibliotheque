json.array!(@rhcbranches) do |rhcbranch|
  json.extract! rhcbranch, :id, :branch
  json.url rhcbranch_url(rhcbranch, format: :json)
end
