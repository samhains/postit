PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :posts, except: :destroy do 
    resources :comments, only: :create do
      member do
        post :vote
      end
    end

    member do
      post :vote
    end
  end
  resources :users, except: [:destroy] do
    collection do
      get :vote
    end
  end
  resources :categories, only: [:create, :new, :show]
end
