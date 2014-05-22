class CreateRhcbranches < ActiveRecord::Migration
  def change
    create_table :rhcbranches do |t|
      t.string :branch

      t.timestamps
    end
  end
end
