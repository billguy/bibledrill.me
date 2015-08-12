Rails.application.routes.draw do

  resources :pages, only: :show

  resources :books, only: [:index, :show] do
    resources :chapters, only: [:index, :show] do
      resources :verses, only: [:index, :show]
    end
  end

  root to: 'site#index'
end
