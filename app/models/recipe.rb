class Recipe < ApplicationRecord
  has_many :rates

  def update_rate(rate)
    rates << rate
    self.rate = rates.average(:rate)
    save
  end

  def self.fiter_by_cuisine!(cuisine)
    unless cuisine
      cuisines = Recipe.select(:recipe_cuisine).distinct.pluck(:recipe_cuisine)
      message = { error: { message: "one of the type are require as cuisine value (#{cuisines.join(', ')})" } }.to_json
      fail message
    end

    where(recipe_cuisine: cuisine)
  end
end
