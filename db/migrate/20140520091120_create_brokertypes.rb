class CreateBrokertypes < ActiveRecord::Migration
  def change
    create_table :brokertypes do |t|
      t.string :brokertype

      t.timestamps
    end
  end
end
