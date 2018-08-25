class RatesController < ApplicationController
  def create
    raise unless valid_rate_param?(params)

    recipe = Recipe.find(params[:recipe_id])
    rate = Rate.create(rate_params)
    recipe.update_rate(rate)

    render json: recipe, status: :created

  rescue ActiveRecord::RecordNotFound
    render json: nil, status: :not_found
  rescue RuntimeError
    message = { error: { message: 'rate has to be a integer between 1 and 5' } }
    render json: message, status: :bad_request
  end

  private
  def rate_params
    params.require(:rate).permit!
  end

  def valid_rate_param?(params)
    params[:rate] && params[:rate][:rate] && params[:rate][:rate].to_f.between?(1,5)
  end
end
