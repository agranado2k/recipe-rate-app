# frozen_string_literal: true

# Entity Recipe
class Recipe < ApplicationRecord
  has_many :rates

  def update_rate(rate)
    rates << rate
    self.rate = rates.average(:rate)
    save
  end

  def self.fiter_by_cuisine!(cuisine)
    unless cuisine
      cs = Recipe.select(:recipe_cuisine).distinct.pluck(:recipe_cuisine)
      msg = "one of the type are require as cuisine value (#{cs.join(', ')})"
      error = { error: { message: msg } }.to_json
      raise error
    end

    where(recipe_cuisine: cuisine)
  end
end
