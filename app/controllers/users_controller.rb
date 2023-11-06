# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile; end

  def cancel_account; end
end
