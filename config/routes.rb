Battleshipgame::Application.routes.draw do

  root 'game#index'

  get 'game/placeships', :to => 'game#placeships'
  get 'game/placecomp', :to => 'game#placecomp'
  resources :game
end
