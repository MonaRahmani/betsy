class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :credit_card_name
      t.string :credit_card_num
      t.date :cc_exp_date
      t.string :cvv_num
      t.string :status

      t.timestamps
    end
  end
end
