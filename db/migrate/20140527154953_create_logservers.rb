class CreateLogservers < ActiveRecord::Migration
  def change
    create_table :logservers do |t|
      t.string, :ip
      t.string :hostname

      t.timestamps
    end
  end
end
