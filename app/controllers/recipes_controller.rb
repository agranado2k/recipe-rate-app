class RecipesController < ApplicationController
  def index
    limit = params[:limit].present? ? params[:limit].to_i : 30
    page = params[:page].present? ? params[:page].to_i : 1

    offset = (page- 1) * limit
    recipes = Recipe.limit(limit).offset(offset)

    render json: recipes, status: :ok
  end
end
