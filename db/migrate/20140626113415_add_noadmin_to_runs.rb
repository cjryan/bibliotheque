class AddNoadminToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :noadmin, :boolean
  end
end
