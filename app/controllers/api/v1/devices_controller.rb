class Api::V1::DevicesController < ApplicationController
  respond_to :json
  def show
    begin
      @device = Device.find(params[:id])
      respond_with @device         
    rescue
      head 404
    end
  end
    
  def create
    device = Device.new(device_params)
    if device.save
      render json: device, status: 201
    else
      render json: {errors: device.errors}, status: 422
    end
  end
  
  def update
    device = Device.find(params[:id])
    if device.update(device_params)
      render json: device, status: 200
    else
      render json: {errors: device.errors}, status: 422
    end
  end

  def destroy
    device = Device.find(params[:id])
    device.visible = false
    if device.update(device_params)
      render json: device, status: 200
    else
      render json: {errors: device.errors}, status: 422
    end
  end
  

  private
  def device_params
    params.require(:device).permit(:name, :description, :status, :address)
  end

end
