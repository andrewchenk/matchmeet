class GroupsController < ApplicationController
    before_action :authenticate_user!  
    
    def index
        @groups = Group.all
        @user_lat = request.location.latitude
        @user_lon = request.location.longitude
    end

    def new
        @group = Group.new
    end

    def create
        @group_lat = @user_lat
        @group_lon = @user_lon

        @group = Group.create(group_params)
        @group.update_attributes({:latitude => @group_lat,:longitude => @group_lon, :author => current_user.user_name,:author_id => current_user.id})
        redirect_to groups_path
    end

    def show
        @group = Group.find(params[:id])
    end

    def destroy
        @group = Group.find(params[:id])
        @group.delete
        redirect_to groups_path
    end

    def map
        @all_groups = Group.all
        @userlat = request.location.latitude
        @userlon = request.location.longitude
    end


    private def group_params
        params.require(:group).permit(:name,:category,:description)
    end
end
