class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.belongs_to :recipe, index: true

      t.integer :rate

      t.timestamps
    end
  end
end
