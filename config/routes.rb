Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/chords' => 'chords#index'
  get '/games/:id' => 'games#show'
  post '/users' => 'users#create'
  get '/users' => 'users#index'
  post '/auth' => 'auth#create'
  patch '/user_levels/:id' => 'user_levels#update'
  delete '/users' => 'users#destroy'
end
