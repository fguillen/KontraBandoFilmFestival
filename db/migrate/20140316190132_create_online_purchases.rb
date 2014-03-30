class CreateOnlinePurchases < ActiveRecord::Migration
  def change
    create_table :online_purchases do |t|
      t.integer :short_film_user_id, :null => false
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.datetime :paid_at
      t.datetime :canceled_at
      t.string :error
      t.string :token
      t.string :payer_id
      t.string :description, :null => false

      t.timestamps
    end
  end
end
