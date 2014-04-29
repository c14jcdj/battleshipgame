Battleshipgame::Application.routes.draw do

  root 'game#index'

  get 'game/placeships', :to => 'game#placeships'
  resources :game, :board
end
