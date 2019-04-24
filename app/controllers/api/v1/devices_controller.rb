class Api::V1::DevicesController < ApplicationController
  respond_to :json
  def show
    @device = Device.find(params[:id])
    respond_with @device        
  end
    
end
