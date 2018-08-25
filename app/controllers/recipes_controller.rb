class RecipesController < ApplicationController
  def index
    limit = params[:limit].present? ? params[:limit].to_i : 30
    page = params[:page].present? ? params[:page].to_i : 1
    filters = params[:filter].present? ? params[:filter] : nil

    return render json: filter_error_message, status: :bad_request unless filters

    offset = (page- 1) * limit
    recipes = Recipe.limit(limit).offset(offset)
    recipes = recipes.where(recipe_cuisine: filters) if filters

    render json: recipes, status: :ok
  end

  def show
    recipe = Recipe.find(params[:id])

    render json: recipe, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: nil, status: :not_found
  end

  def create
    Recipe.create!(recipe_params)

    render json: nil, status: :created
  rescue ActiveModel::UnknownAttributeError
    render json: nil, status: :bad_request
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update_attributes(recipe_params)

    render json: recipe, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: nil, status: :not_found
  rescue ActiveModel::UnknownAttributeError
    render json: nil, status: :bad_request
  end

  private

  def recipe_params
    params.require(:recipe).permit!
  end

  def filter_error_message
    cuisines = Recipe.select(:recipe_cuisine).distinct.pluck(:recipe_cuisine)
    { error: { message: "one of the type are require as filter value (#{cuisines.join(', ')})" } }
  end
end
