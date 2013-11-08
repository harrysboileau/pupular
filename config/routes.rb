Pupular::Application.routes.draw do
  
  resources :dogs do
    resources :events 
    resources :messages
    resources :profiles, :only => [:new, :edit]
    get '/name' => 'dogs#name'
  end


  get '/doghouse' => 'dogs#doghouse'
  get '/search' => 'dogs#search'
  post '/search' => 'dogs#filter_search'
  post '/add_friend/:pending_pal_id' => 'dogs#add_friend'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#signout'
  root :to => 'welcome#index'



end










