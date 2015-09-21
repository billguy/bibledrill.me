Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :pages, only: :show
  resources :books, only: [:index, :show] do
    get 'search', on: :collection
    resources :chapters, only: [:index, :show] do
      resources :verses, only: [:index, :show]
    end
  end

  resources :drills, only: [:index, :new, :create]
  resources :contacts, only: [:index, :new, :create], path: :contact
  resources :highlights, only: [:update]
  resources :studies
  root to: 'drills#index'
end