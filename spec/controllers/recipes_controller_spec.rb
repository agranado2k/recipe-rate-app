require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'GET /v1/recipes' do
    let(:page) { nil }
    let(:limit) { nil }
    let(:params) { { page: page, limit: limit } }
    before do
      7.times { create(:recipe) }

      get :index, params: params
    end

    it 'returns HTTP statsu 200' do
      expect(response).to have_http_status 200
    end

    it 'return users' do
      body = JSON.parse(response.body)

      expect(body.size).to eq(7)
    end

    context 'returns all users' do
      let(:limit) { 5 }

      it 'return users page 1 (default)' do
        body = JSON.parse(response.body)

        expect(body.size).to eq(5)
      end

      context 'page 2' do
        let (:page) { 2 }
        it 'return users from page 2 ' do
          body = JSON.parse(response.body)

          expect(body.size).to eq(2)
        end
      end
    end
  end
end
