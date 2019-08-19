class CreateCompaniesDoses < ActiveRecord::Migration[5.2]
  def change
    create_table :companies_doses do |t|
      t.references :group, foreign_key: true
      t.references :company, foreign_key: true
      t.float :portion

      t.timestamps
    end
  end
end
