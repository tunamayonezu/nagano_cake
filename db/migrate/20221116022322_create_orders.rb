class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false
      t.string :postcode, null: true
      t.text :address, null: true
      t.string :name, null: true
      t.integer :status, null: false, default: "0"
      t.timestamps
    end
  end
end
