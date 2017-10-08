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
        @user = current_user
        if @user.scores.nil?
            @user.scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        end
        if @user.image_urls.nil?
            @user.image_urls = [params[:url]]
        else
            @user.image_urls.push(params[:url])
        end
        result = `python #{Rails.root}/lib/computer_vision.py #{params[:url]}`
        @user.image_urls.push(result)
        @user.scores = JSON.parse(result)
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
