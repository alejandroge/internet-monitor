class NetworkDisconnectionsController < ApplicationController
  def index
    @network_disconnections = NetworkDisconnection.all
    render "network_disconnections/index"
  end
end
