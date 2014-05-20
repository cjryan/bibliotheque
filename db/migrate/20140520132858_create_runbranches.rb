class CreateRunbranches < ActiveRecord::Migration
  def change
    create_table :runbranches do |t|
      t.belongs_to :run
      t.belongs_to :rhcbranch
      t.timestamps
    end
  end 
end
