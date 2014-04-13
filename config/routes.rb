Rails.application.routes.draw do
  root to: "users#show"

  get "/login"    => "pages#home"

  post "/friends" => "friends#create"

  resource :user, :only => [:show, :edit, :update]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
