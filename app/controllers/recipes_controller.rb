class RecipesController < ApplicationController
  def index
    limit = params[:limit].present? ? params[:limit].to_i : 30
    page = params[:page].present? ? params[:page].to_i : 1
    filters = params[:filter].present? ? params[:filter].permit(:recipe_cuisine) : nil

    return render json: {}, status: :bad_request unless filters

    offset = (page- 1) * limit
    recipes = Recipe.limit(limit).offset(offset)
    recipes = recipes.where(filters) if filters

    render json: recipes, status: :ok
  end

  def show
    recipe = Recipe.find(params[:id])

    render json: recipe, status: :ok
  rescue
    render json: nil, status: :not_found
  end
end
