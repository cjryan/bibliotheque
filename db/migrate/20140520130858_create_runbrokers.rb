class CreateRunbrokers < ActiveRecord::Migration
  def change
    create_table :runbrokers do |t|
      t.belongs_to :run
      t.belongs_to :brokertypes
      t.timestamps
    end
  end
end


