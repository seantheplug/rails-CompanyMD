class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :user_setting
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
