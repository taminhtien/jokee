Rails.application.routes.draw do
  root 'votes#index'

  resources :jokes, only: [] do
    resources :votes, only: [:new, :create]
  end
end
