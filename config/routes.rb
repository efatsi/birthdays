Rails.application.routes.draw do
  root to: "pages#home"

  resource :user

  post "/friends" => "friends#create"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
