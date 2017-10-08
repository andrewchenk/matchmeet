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
            @user.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(",")
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
        puts 'hi'
        # create 5 users
        u = User.new
        u.user_name = 'Andrew Sleepy'
        u.email = 'a@berkeley.edu'
        u.password = 'aaaaaa'
        u.scoresstr = [0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,3,8,0,0,0,0,0,0,0].join(",")
        u.save!

        u1 = User.new
        u1.user_name = 'Jonat OP'
        u1.email = 'b@berkeley.edu'
        u1.password = 'bbbbbb'
        u1.scoresstr = [0,6,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,3,0,0,0,0,0,0,0].join(",")
        u1.save!

        u2 = User.new
        u2.user_name = 'Andrew 2'
        u2.email = 'c@berkeley.edu'
        u2.password = 'cccccc'
        u2.scoresstr = [10,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0].join(",")
        u2.save!

        u3 = User.new
        u3.user_name = 'Gary Aaa'
        u3.email = 'd@berkeley.edu'
        u3.password = 'dddddd'
        u3.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,5,0,0,0,0,1,0,0].join(",")
        u3.save!

        u4 = User.new
        u4.user_name = 'mongo db'
        u4.email = 'e@berkeley.edu'
        u4.password = 'eeeeee'
        u4.scoresstr = [0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(",")
        u4.save!

    end
end
