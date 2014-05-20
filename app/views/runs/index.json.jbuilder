json.array!(@runs) do |run|
  json.extract! run, :id, :broker, :testrun_id, :caserun_ids, :accounts, :job_count, :max_gears, :debug, :tcms_user, :tcms_password, :accounts_per_job
  json.url run_url(run, format: :json)
end
