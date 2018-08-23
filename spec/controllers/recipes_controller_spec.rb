require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'GET /v1/recipes' do
    before do
      create(:recipe)
      create(:recipe)

      get :index
    end

    it 'returns HTTP statsu 200' do
      expect(response).to have_http_status 200
    end

    it 'returns all users' do
      body = JSON.parse(response.body)

      expect(body.size).to eq(2)
    end
  end
end
