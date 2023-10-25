# frozen_string_literal: true

class UsersController < ApplicationController
  def profile
    @user = current_user
  end
end
