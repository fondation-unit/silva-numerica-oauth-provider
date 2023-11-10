# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: "oauth_applications"
  end

  use_doorkeeper_device_authorization_grant do
    controller device_authorizations: "custom_device_authorizations"
  end
  get "/oauth/device/success", to: "custom_device_authorizations#success", as: :oauth_device_authorizations_success

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  namespace :api do
    namespace :v1 do
      get "/me", to: "credentials#me"
    end
  end

  root to: "doorkeeper/authorized_applications#index"
  get "profile", to: "users#profile", as: :profile
  get "cancel_account", to: "users#cancel_account", as: :cancel_account
end
