# frozen_string_literal: true

class CustomDeviceAuthorizationsController < Doorkeeper::DeviceAuthorizationGrant::DeviceAuthorizationsController
  layout "authorize"
end
