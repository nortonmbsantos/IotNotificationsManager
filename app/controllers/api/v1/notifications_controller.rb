class Api::V1::NotificationsController < ApplicationController

  respond_to :json
    
  def show
    begin
      notification = Notification.find(params[:id])
      render json: notification 
    rescue
      render status: 404    
    end
  end

  def create
    notification = Notification.new(notification_params)
    if notification.save
      render json: notification, status: 201
    else
      render json: {errors: notification.errors}, status: 422
    end
  end
  
private

  def notification_params
    params.require(:notification).permit(:device_id, :message, :status, :read)
  end


end
