class AddExpYearColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cc_exp_year, :integer
  end
end
