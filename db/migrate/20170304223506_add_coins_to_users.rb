class AddCoinsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coins, :integer
  end
end
