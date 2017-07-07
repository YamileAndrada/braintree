class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :payment_method_token
      t.string :braintree_subscription_id
      t.string :plan_id

      t.timestamps
    end
  end
end
