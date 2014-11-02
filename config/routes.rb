PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get  '/register', to: 'users#new'
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  get  '/logout',   to: 'sessions#destroy'

  resources :categories, only:   [:show, :new, :create]
  resources :users,      except: [:destroy, :new, :index]

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end
	  resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
	end
end
