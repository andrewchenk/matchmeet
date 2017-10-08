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
        if @user.scoresstr.nil?
            @user.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(',')
        end
        if @user.image_urls.nil?
            @user.image_urls = [params[:url]]
        else
            @user.image_urls.push(params[:url])
        end

        result = `python #{Rails.root}/lib/computer_vision.py #{params[:url]}`
        @user.image_urls.push(result)
        str = result[1..-2]
        add = str.split(',').map(&:to_i)

        total = @user.scoresstr.split(',').map(&:to_i)
        # add to user's score vector
        total = total.map.with_index{ |m,i| m + add[i].to_i }
        @user.scoresstr = total.join(',')
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

    def test
        # create 5 users
        u = User.new
        u.user_name = 'aasddandrewa'
        u.email = 'aandsdaadrew@berkeley.edu'
        u.password = 'bdaaaaaaaaa'
        u.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(",")
        u.save
    end
end
