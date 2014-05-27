class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :broker
      t.string :testrun_id
      t.string :caserun_ids
      t.string :accounts
      t.integer :job_count
      t.integer :max_gears
      t.boolean :debug
      t.string :tcms_user
      t.string :tcms_password
      t.integer :accounts_per_job
      t.integer :rhcbranch, :references => :rhcbranch
      t.integer :brokertype, :references => :brokertype 
      t.string :docker_url, :references => :dockerserver
      t.string :image_url
      t.string :logserver, :references => :logserver
      t.timestamps
    end
  end
end


