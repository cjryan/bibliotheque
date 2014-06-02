class CreateRunlogservers < ActiveRecord::Migration
  def change
    create_table :runlogservers do |t|
      t.references :run, index: true
      t.references :logserver, index: true

      t.timestamps
    end
  end
end
