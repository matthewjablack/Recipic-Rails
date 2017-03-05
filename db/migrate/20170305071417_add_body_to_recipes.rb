class AddBodyToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :body, :text
  end
end
