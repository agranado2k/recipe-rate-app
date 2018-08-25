Rails.application.routes.draw do
  scope 'v1' do
    resources :recipes, only: [:index, :show, :create, :update] do
      resources :rates, only: [:create]
    end
  end
end
