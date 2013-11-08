Pupular::Application.routes.draw do
  
  resources :dogs do
    resources :events 
    resources :messages
    resources :profiles, :only => [:new, :edit]
    get '/name' => 'dogs#name'
  end


  get '/doghouse' => 'dogs#doghouse'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#signout'
  root :to => 'welcome#index'



end










