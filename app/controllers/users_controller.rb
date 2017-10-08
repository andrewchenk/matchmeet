class UsersController < ApplicationController
    before_action :authenticate_user!  

    def show
        if current_user
            @user = User.find(params[:id])
        else
            redirect_to '/users/sign_in'
        end
    end

    def add_url
        @user = User.find(params[:id])        
        if @user.Image_Urls.nil?
            @user.Image_Urls = [params[:url]]
          else
            @user.Image_Urls << params[:url].to_s
          end
        @user.save
        redirect_to user_path
    end

    def follow
			current_user.follow(Group.find(params[:id]))
			redirect_to group_path(params[:id])
	end

	def unfollow
			current_user.stop_following(Group.find(params[:id]))
			redirect_to group_path(params[:id])
	end
end
