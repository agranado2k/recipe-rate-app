# frozen_string_literal: true

# Controller to resoure recipes
class RecipesController < ApplicationController
  def index
    limit = params[:limit].present? ? params[:limit].to_i : 30
    page = params[:page].present? ? params[:page].to_i : 1
    cuisine = params[:cuisine].present? ? params[:cuisine] : nil

    offset = (page - 1) * limit
    recipes = Recipe.fiter_by_cuisine!(cuisine)
    recipes = recipes.limit(limit).offset(offset)

    render json: recipes, status: :ok
  rescue RuntimeError => e
    render json: e.message, status: :bad_request
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
end
