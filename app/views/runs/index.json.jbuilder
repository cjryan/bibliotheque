json.array!(@runs) do |run|
  json.extract! run, :id, :broker, :testrun, :caseruns, :accounts, :maxgears, :tcms_user, :tcms_password, :rhcbranch_id, :brokertype_id, :accounts_per_job
  json.url run_url(run, format: :json)
end
