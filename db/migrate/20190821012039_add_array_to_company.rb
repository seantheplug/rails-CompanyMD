class AddArrayToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :times, :string, array: true, default: []
    add_column :companies, :prices, :float, array: true, default: []
  end
end
