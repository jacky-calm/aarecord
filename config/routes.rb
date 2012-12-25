Aarecord::Application.routes.draw do
  resources :bills do
    post 'pay', :on => :member
    post 'clear', :on => :collection
  end


  resources :accounts, :except => [:show, :edit]


  authenticated :user do
    root :to => 'accounts#index'
  end
  root :to => "accounts#index"
  devise_for :users
  resources :users
end
