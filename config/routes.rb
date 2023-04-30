Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :posts
  resources :users, only: %i[index show] do
    member do
      post :follow
      delete :unfollow
    end
  end
  resource :authentication, only: %i[new create destroy]
end
