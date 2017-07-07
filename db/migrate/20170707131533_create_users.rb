class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.string :credit_card_token
      t.string :state
      t.string :city
      t.string :street
      t.integer :postal_code
      t.string :country_code
      t.string :customer_id
      t.timestamps null: false
    end
  end
end
