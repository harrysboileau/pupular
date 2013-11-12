Pupular::Application.routes.draw do

  resources :dogs do
    resources :events
    resources :messages
  end

  resources :profiles, :only => [:new, :create, :edit, :update]


  post '/name' => 'dogs#savehuman'
  get '/name' => 'dogs#name'

  get '/doghouse' => 'dogs#doghouse'

  get '/search' => 'dogs#search'
  post '/search' => 'dogs#filter_search'

  get '/get_id' => 'messages#get_id'

  post '/add_friend/:pending_pal_id' => 'dogs#add_friend', as: :add_friend
  post '/reject_friend/:pending_pal_id' => 'dogs#reject_friend', as: :reject_friend
  resources :sessions, only: [:new, :create, :destroy]
  match '/signin' => 'sessions#new', as: :signin
  match '/signout' => 'sessions#destroy', as: :signout
  post '/friend_request/:pending_pal_id' => 'dogs#friend_request', as: :friend_request
  post '/load_friends' => 'dogs#load_friends'
  post '/verify_friend' => 'dogs#verify_friend'
  post '/add_friends_to_event' => 'dogs#add_friends_to_event'
  post '/accept_invitation' => 'dogs#accept_invitation'
  post '/decline_invitation' => 'dogs#decline_invitation'
  root :to => 'welcome#index'

end










