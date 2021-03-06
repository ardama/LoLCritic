LoLCritic::Application.routes.draw do

  root :to => 'home#index'
  get 'account' => 'home#account', :as => 'account_page'
  get 'help' => 'home#help', :as => 'help_page'
  get 'filter_by' => 'home#filter_by_tags', :as => 'filter'

  authenticated :user do
    root :to => 'videos#index'
  end

  devise_for :users

  get ':tab' => 'home#index'

  resources :videos do
    post 'rate', :on => :member
    get 'search', :on => :collection
  end

  get 'notifications' => 'notifications#index'
  get 'notifications/update' => 'notifications#update'

  resources :comments, :reviews do
    member do 
      post 'upvote'
      post 'downvote'
    end
  end

  resources :flags do
    member do
      get 'select'
      get 'remove'
    end
  end

end
