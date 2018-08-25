require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#update_rate' do
    let(:recipe) { create(:recipe) }
    let(:rate) { create(:rate, rate: 4, recipe: recipe) }

    it 'update the recipe rate' do
      recipe.update_rate(rate)

      expect(recipe.rate).to eq(4)
    end
  end
end
