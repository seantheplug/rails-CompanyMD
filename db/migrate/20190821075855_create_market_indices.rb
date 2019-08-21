class CreateMarketIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :market_indices do |t|
      t.string :name
      t.string :ticker
      t.float :price
      t.float :high
      t.float :low
      t.float :change
      t.float :change_percent

      t.timestamps
    end
  end
end
