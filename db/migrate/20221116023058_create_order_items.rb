class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|

      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :quantiy, null: false
      t.integer :production_status, null: false
      t.integer :purchase_price, null: false


      t.timestamps
    end
  end
end