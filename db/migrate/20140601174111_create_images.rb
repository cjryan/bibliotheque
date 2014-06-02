class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :uuid
      t.string :tag
      t.references :dockerserver, index: true

      t.timestamps
    end
  end
end
