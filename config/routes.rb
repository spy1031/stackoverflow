Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "questions#index"
  resources :questions do
    member do
      post :favorite
      post :unfavorite
    end
    
    member do
      post :upvote
      post :unupvote
    end
    
    resources :solutions, only: [:create]
  end
  
  resources :users, only: [:edit, :show, :update] do
    member do
      get :favorite
    end
  end

end
