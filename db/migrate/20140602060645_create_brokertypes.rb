class CreateBrokertypes < ActiveRecord::Migration
  def change
    create_table :brokertypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
