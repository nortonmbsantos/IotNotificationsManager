class Api::V1::GroupsController < ApplicationController
    respond_to :json
    def show
      begin
        @group = Group.find(params[:id])
        respond_with @group         
      rescue
        head 404
      end
    end
      
    def create
      group = Group.new(group_params)
      if group.save
        render json: group, status: 201
      else
        render json: {errors: group.errors}, status: 422
      end
    end
    
    def update
      group = Group.find(params[:id])
      if group.update(group_params)
        render json: group, status: 200
      else
        render json: {errors: group.errors}, status: 422
      end
    end
  
    def destroy
      group = Group.find(params[:id])
      group.visible = false
      if group.update(group_params)
        render json: group, status: 200
      else
        render json: {errors: group.errors}, status: 422
      end
    end
    
  
    private
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
