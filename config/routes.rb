# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: "oauth_applications"
  end

  use_doorkeeper_device_authorization_grant

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  namespace :api do
    namespace :v1 do
      get "/me" => "credentials#me"
    end
  end

  root to: "doorkeeper/authorized_applications#index"
  get "profile", to: "users#profile", as: :profile
  get "cancel_account", to: "users#cancel_account", as: :cancel_account
end
