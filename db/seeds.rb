# frozen_string_literal: true
require "dotenv/load"

owner = User.create!(
  email: "user@example.com",
  firstname: "Admin",
  lastname: "User",
  password: "#{ENV["ADMIN_PASSWORD"]}",
  password_confirmation: "#{ENV["ADMIN_PASSWORD"]}"
)

app = Doorkeeper::Application.create!(
  name: "#{ENV["DEFAULT_SERVICE_NAME"]}",
  redirect_uri: "#{ENV["DEFAULT_SERVICE_URI"]}",
  owner: owner
)
