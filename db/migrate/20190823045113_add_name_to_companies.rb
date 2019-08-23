class AddNameToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :name, :string
  end
end
