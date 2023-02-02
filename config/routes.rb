Rails.application.routes.draw do
  resources :gather_informations
  resources :move_armies
  resources :raise_armies
  resources :path_to_power_constructions
  resources :resource_generator_constructions
  resources :trade_request_responses
  resources :fund_request_responses
  resources :funding_request_resources
  resources :funding_request_player_roles
  resources :funding_requests
  resources :fundings
  resources :constructions
  resources :player_military_unit_roles
  resources :military_units
  resources :resource_generators
  resources :trade_player_roles, only: [:index,:show,:edit,:update,:destroy]
  resources :trade_request_resources
  resources :trade_requests do
    resources :trade_player_roles, only:[:index,:new,:create]
  end
  resources :player_loyalty_roles
  resources :player_loyalties
  resources :player_actions
  resources :player_resources
  resources :rounds
  resources :player_match_roles
  resources :matches
  resources :players
  resources :games
  resources :results_pages
  resources :gathered_information

  get 'sign_up', to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "login", to: "login#new"
  post "login", to: "login#create"
  get "logout", to:"login#destroy"

  get 'game_page/new', to: "game_page#new"
  get 'game_pages',to: "game_page#index"
  post 'game_page/show', to: "game_page#show"
  get 'game_page/show', to:"game_page#show"
  get 'leave_game_page',to: 'game_page#leave_game_page'

  get 'end_round',to:'rounds#end_round'
  get 'rescind_end_round',to:'rounds#rescind_end_round'

  post "take_action",to:"player_actions#new"
  post "player_action_raise_army", to: "player_actions#create_raise_army_action"
  get "/player_actions_move_army", to: "player_actions#move_army"

  post "/trade_requests/new", to: "trade_requests#new"

  get "/move_army", to:"move_armies#new"

  get "results_pages/results_page", to:"results_pages#show"
  get "how_to_play", to:"main#how_to_play"
  root to:"main#index"
end
