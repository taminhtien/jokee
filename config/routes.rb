Rails.application.routes.draw do
  root 'votes#index'

  resources :jokes, only: [] do
    resources :votes, only: [:new, :create]
  end

  get 'jokes/votes/goodbye' => 'votes#goodbye', as: :goodbye_votes
end
