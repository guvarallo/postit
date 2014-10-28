PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :categories, only: [:show, :new, :create]

  resources :posts, except: [:destroy] do
	  resources :comments, only: [:create]
	end
end
