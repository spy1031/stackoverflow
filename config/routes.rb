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
      post :upvote      # 投贊成票
      post :unupvote    # 若投過贊成票，取消掉
      
      post :downvote    # 投反對票
      post :undownvote  # 若投過反對票，取消掉
    end
    
    resources :solutions, only: [:create]
  end
  
  resources :users, only: [:edit, :show, :update] do
    member do
      get :favorite
    end
  end

end
