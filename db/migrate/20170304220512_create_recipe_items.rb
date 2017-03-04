class CreateRecipeItems < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_items do |t|
      t.integer :item_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
