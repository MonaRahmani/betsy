class RemoveMerchantIdFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :merchant_id
  end
end
