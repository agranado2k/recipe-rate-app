class AddRateToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :rate, :integer
  end
end
