Rails.application.routes.draw do
  scope 'v1' do
    resources :recipes, only: [:index]
  end
end
