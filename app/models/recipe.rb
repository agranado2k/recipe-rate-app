class Recipe < ApplicationRecord
  has_many :rates

  def update_rate(rate)
    rates << rate
    self.rate = rates.average(:rate)
    save
  end
end
