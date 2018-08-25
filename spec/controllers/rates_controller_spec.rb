require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  context 'POST /v1/recipes/:id/rates' do
    let(:recipe_id) { 1 }
    let(:rate_attrs_1) { { rate: 1 } }
    let(:rate_attrs_5) { { rate: 5 } }

    before do
      Timecop.freeze(Time.zone.now)
      create(:recipe, id: 1)

      post :create, params: { recipe_id: recipe_id, rate: rate_attrs_1 }
      post :create, params: { recipe_id: recipe_id, rate: rate_attrs_5 }
    end
    after { Timecop.return }

    it 'returns HTTP statsu 201' do
      expect(response).to have_http_status 201
    end

    it 'return recipe with field updated' do
      body = JSON.parse(response.body)

      expect(body['rate']).to eq(3)
    end

    context 'rate has to be between 1 and 5' do
      before { post :create, params: { recipe_id: recipe_id, rate: rate_attrs } }
      context 'rate less than 1' do
        let(:rate_attrs) { { rate: 0.9 } }

        it 'returns HTTP statsu 400' do
          expect(response).to have_http_status 400
        end

        it 'returns error message' do
          body = JSON.parse(response.body)
          expect(body['error']).to eq({ 'message' => 'rate has to be a integer between 1 and 5' })
        end
      end

      context 'rate greater than 5' do
        let(:rate_attrs) { { rate: 5.1 } }

        it 'returns HTTP statsu 400' do
          expect(response).to have_http_status 400
        end

        it 'returns error message' do
          body = JSON.parse(response.body)
          expect(body['error']).to eq({ 'message' => 'rate has to be a integer between 1 and 5'})
        end
      end
    end

    context 'recipe not found' do
      let(:recipe_id) { 'invalid_id' }

      it 'returns HTTP statsu 404' do
        expect(response).to have_http_status 404
      end
    end
  end
end
