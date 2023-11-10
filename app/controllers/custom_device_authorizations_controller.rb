# frozen_string_literal: true

class CustomDeviceAuthorizationsController < Doorkeeper::DeviceAuthorizationGrant::DeviceAuthorizationsController
  layout "authorize"

  def success
    render "doorkeeper/device_authorization_grant/device_authorizations/success"
  end

  private
    def authorization_success_response
      respond_to do |format|
        format.html { redirect_to oauth_device_authorizations_success_url, notice: notice }
        format.json { head :no_content }
      end
    end
end
