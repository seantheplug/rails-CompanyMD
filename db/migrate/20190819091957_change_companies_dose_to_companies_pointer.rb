class ChangeCompaniesDoseToCompaniesPointer < ActiveRecord::Migration[5.2]
  def change
    rename_table :companies_doses, :companies_pointers
  end
end
