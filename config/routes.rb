Battleshipgame::Application.routes.draw do

  root 'game#index'
  resources :game
end
