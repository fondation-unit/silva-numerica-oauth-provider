# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @applications = current_user.oauth_applications.ordered_by(:created_at) if current_user
  end
end
