class RemoveRecipeIdFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :recipe_id
  end
end
