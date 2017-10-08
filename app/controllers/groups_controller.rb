class GroupsController < ApplicationController
    before_action :authenticate_user!

    def index
        if (User.order(:id).last.welcomed != true)
          UserMailer.welcome_email(User.order(:id).last).deliver_now
          # User.order(:id).last.welcomed = true
        end
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
        UserMailer.create_email(User.find(@group.author_id), @group).deliver_now
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
        @groups = Group.all
        @userlat = request.location.latitude
        @userlon = request.location.longitude
    end

    def test
        g = Group.new
        g.name = ''
        g.description = ''
        g.scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        g.save!

        @group = Group.all
    end

    def describe
        puts 'Describe'

        options = {
            max_candidates: '1'
        }

        # image url
        res = @client.describe(IMAGE_URL, options)
        puts res.body

        # image file
        #res = @client.describe(IMAGE_FILE_PATH, options)
        #puts res.body
      end

    private def group_params
        params.require(:group).permit(:name,:category,:description)
    end
end
