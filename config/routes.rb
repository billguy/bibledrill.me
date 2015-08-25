Rails.application.routes.draw do

  devise_for :users, controller: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :books, only: [:index, :show] do
    resources :chapters, only: [:index, :show] do
      resources :verses, only: [:index, :show]
    end
  end

  root to: 'books#index'
end
