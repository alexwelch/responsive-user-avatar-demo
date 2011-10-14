ResponsiveUserAvatar::Application.routes.draw do
  resources :users, :only => [:index, :show]
  match "users/avatars/:size.jpg" => "users#avatar"
  root :to => "users#index"
end
