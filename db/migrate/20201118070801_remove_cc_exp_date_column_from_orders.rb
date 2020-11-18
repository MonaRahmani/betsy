class RemoveCcExpDateColumnFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :cc_exp_date
  end
end
