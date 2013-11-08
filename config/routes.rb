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
  post '/add_friend/:pending_pal_id' => 'dogs#add_friend'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#signout'
  root :to => 'welcome#index'

end










