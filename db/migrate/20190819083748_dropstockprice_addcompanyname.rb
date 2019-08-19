class DropstockpriceAddcompanyname < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :stock_price
    add_column :companies, :ticker, :string
  end
end
