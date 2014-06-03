Rails.application.routes.draw do
  root to: "users#show"

  get "/login"    => "pages#home"

  resources :friends

  post "/new_friend" => "friends#custom_create"

  resource :user, :only => [:show, :edit, :update] do
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
