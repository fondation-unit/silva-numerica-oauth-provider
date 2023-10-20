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

puts "Application: "
puts "name: #{app.name}"
puts "redirect_uri: #{app.redirect_uri}"
puts "uid: #{app.uid}"
puts "secret: #{app.secret}"
