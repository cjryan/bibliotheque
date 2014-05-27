class CreateLogservers < ActiveRecord::Migration
  def change
    create_table :logservers do |t|
      t.string :hostname
      t.timestamps
    end
  end
end
