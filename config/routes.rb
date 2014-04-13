Rails.application.routes.draw do
  root to: "pages#home"

  resource :user

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
