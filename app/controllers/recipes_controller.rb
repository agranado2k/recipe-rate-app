class RecipesController < ApplicationController
  def index
    recipes = Recipe.all

    render json: recipes, status: :ok
  end
end
