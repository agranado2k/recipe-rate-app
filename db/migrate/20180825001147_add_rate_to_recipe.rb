# frozen_string_literal: true

#Include the association between Recipe and Rates
class AddRateToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :rate, :integer
  end
end
