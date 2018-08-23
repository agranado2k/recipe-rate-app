class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string  :box_type
      t.string  :title
      t.string  :slug
      t.string  :short_title
      t.text    :marketing_description
      t.integer :calories_kcal
      t.integer :protein_grams
      t.integer :fat_grams
      t.integer :carbs_grams
      t.string  :bulletpoint1
      t.string  :bulletpoint2
      t.string  :bulletpoint3
      t.string  :recipe_diet_type_id
      t.string  :season
      t.string  :base
      t.string  :protein_source
      t.integer :preparation_time_minutes
      t.integer :shelf_life_days
      t.string  :equipment_needed
      t.string  :origin_country
      t.string  :recipe_cuisine
      t.text    :in_your_box
      t.integer :gousto_reference

      t.timestamps
    end
  end
end

