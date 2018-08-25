require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'PUT /v1/recipes/:id' do
    let(:recipe_id) { 1 }
    let(:recipe_attrs) { { title: 'New title' } }
    before do
      Timecop.freeze(Time.zone.now)
      @recipe = create(:recipe, id: 1, title: 'Old title')
      put :update, params: { id: recipe_id, recipe: recipe_attrs }
    end
    after { Timecop.return }

    it 'returns HTTP statsu 200' do
      expect(response).to have_http_status 200
    end

    it 'return recipe with field updated' do
      body = JSON.parse(response.body)

      expect(body['title']).to eq(recipe_attrs[:title])
    end

    context 'with invalid attr' do
      let(:recipe_attrs) { { invalid_attr: 'invalid' } }

      it 'returns HTTP statsu 400' do
        expect(response).to have_http_status 400
      end
    end

    context 'recipe not found' do
      let(:recipe_id) { 'invalid_id' }

      it 'returns HTTP statsu 404' do
        expect(response).to have_http_status 404
      end
    end
  end

  context 'POST /v1/recipes' do
    let(:recipe_attrs) { { title: 'Some recipe', recipe_cuisine: 'italian'  } }
    before do
      Timecop.freeze(Time.zone.now)
      post :create, params: { recipe: recipe_attrs }
    end
    after { Timecop.return }

    it 'returns HTTP statsu 201' do
      expect(response).to have_http_status 201
    end

    context 'with invalid attr' do
      let(:recipe_attrs) { { invalid_attr: 'invalid' } }

      it 'returns HTTP statsu 400' do
        expect(response).to have_http_status 400
      end
    end
  end

  context 'GET /v1/recipes/:id' do
    let(:recipe_id) { 1 }
    before do
      Timecop.freeze(Time.zone.now)
      @recipe = create(:recipe, id: recipe_id)
    end
    after { Timecop.return }

    context 'recipe not found' do
      before { get :show, params: { id: 'invalid_id'} }
      it 'returns HTTP statsu 404' do
        expect(response).to have_http_status 404
      end
    end

    context 'recipe found' do
      before { get :show, params: { id: recipe_id } }

      it 'returns HTTP statsu 200' do
        expect(response).to have_http_status 200
      end

      it 'return the recipe' do
        body = JSON.parse(response.body)

        expect(body).to eq(JSON.parse(@recipe.to_json))
      end
    end
  end

  context 'GET /v1/recipes' do
    let(:page) { nil }
    let(:limit) { nil }
    let(:filter) { 'italian' }
    let(:params) { { page: page, limit: limit, filter: filter } }
    before do
      18.times { create(:recipe, recipe_cuisine: 'italian') }
      3.times { create(:recipe, recipe_cuisine: 'british') }
      6.times { create(:recipe, recipe_cuisine: 'asian') }
      2.times { create(:recipe, recipe_cuisine: 'brazilian') }

      get :index, params: params
    end

    it 'returns HTTP statsu 200' do
      expect(response).to have_http_status 200
    end

    context 'when there is no filter for cuisine' do
      let(:filter) { nil }

      it 'return HTTP status 400' do
        expect(response).to have_http_status 400
      end

      it 'return message error' do
        body = JSON.parse(response.body)

        expect(body['error']).to eq({ 'message' => 'one of the type are require as filter value (italian, british, asian, brazilian)' })
      end
    end

    it 'return recipes' do
      body = JSON.parse(response.body)

      expect(body.size).to eq(18)
    end

    context 'returns all recipes' do
      let(:limit) { 10 }

      it 'return recipes page 1 (default)' do
        body = JSON.parse(response.body)

        expect(body.size).to eq(10)
      end

      context 'page 2' do
        let (:page) { 2 }
        it 'return recipes from page 2 ' do
          body = JSON.parse(response.body)

          expect(body.size).to eq(8)
        end
      end

      context 'filter by recipe_cuisine' do
        let(:filter) { 'brazilian' }

        it 'brazilian recipes' do
          body = JSON.parse(response.body)

          expect(body.size).to eq(2)
        end
      end
    end
  end
end
