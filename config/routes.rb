Rails.application.routes.draw do
  devise_for :users
  
  resources :topics, except: %i[edit delete], constraints: { id: /\d+/ } do
    post 'star', to: 'topics#star', as: :star
    post 'unstar', to: 'topics#unstar', as: :unstar
  end
  get 'topics/mentions', to: 'topics#mentions', as: :my_mentions
  get 'topics/starred', to: 'topics#starred', as: :my_starred

  resources :profile, only: %i[show edit update], param: :username
  get 'profile', to: 'profile#mine', as: :my_profile

  root 'topics#index'
end
