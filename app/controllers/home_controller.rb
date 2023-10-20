# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @applications = Doorkeeper::Application.all if current_user
  end
end
