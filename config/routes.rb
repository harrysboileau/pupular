Pupular::Application.routes.draw do

  resources :dogs do
    resources :events
    resources :messages
  end

  resources :profiles, :only => [:new, :create, :edit]


  post '/name' => 'dogs#savehuman'
  get '/name' => 'dogs#name'

  get '/doghouse' => 'dogs#doghouse'

  get '/search' => 'dogs#search'
  post '/search' => 'dogs#filter_search'

  post '/add_friend/:pending_pal_id' => 'dogs#add_friend', as: :add_friend

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin' => 'sessions#new', as: :signin
  match '/signout' => 'sessions#destroy', as: :signout
  root :to => 'welcome#index'

end










