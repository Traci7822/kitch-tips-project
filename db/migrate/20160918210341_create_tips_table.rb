class CreateTipsTable < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :name
      t.string :main_ingredient
      t.string :tip
      t.integer :user_id
      t.timestamps
    end
  end
end
