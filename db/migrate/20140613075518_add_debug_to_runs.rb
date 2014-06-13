class AddDebugToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :debug, :boolean
  end
end
