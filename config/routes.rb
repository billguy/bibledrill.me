Rails.application.routes.draw do

  resources :books, only: [:index, :show] do
    resources :chapters, only: [:index, :show] do
      resources :verses, only: [:index, :show]
    end
  end

  root to: 'books#index'
end
