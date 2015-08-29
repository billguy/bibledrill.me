Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :pages, only: :show
  resources :books, only: [:index, :show] do
    resources :chapters, only: [:index, :show] do
      resources :verses, only: [:index, :show]
    end
  end

  get 'random-verse', to: 'site#random_verse', as: :random_verse
  root to: 'site#index'
end
