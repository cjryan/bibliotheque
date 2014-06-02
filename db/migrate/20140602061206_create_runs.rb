class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :broker
      t.integer :testrun
      t.string :caseruns
      t.string :accounts
      t.integer :maxgears
      t.string :tcms_user
      t.string :tcms_password
      t.references :rhcbranch, index: true
      t.references :brokertype, index: true
      t.integer :accounts_per_job

      t.timestamps
    end
  end
end
