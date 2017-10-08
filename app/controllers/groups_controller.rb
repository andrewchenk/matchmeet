class GroupsController < ApplicationController
    before_action :authenticate_user!

    require 'microsoft_computer_vision'
    require 'json'
    subscription_key = ENV['35b0725209e04bb187f8b512e935cc3d']
    @client = MicrosoftComputerVision::Client.new(subscription_key)
    IMAGE_URL = 'https://upload.wikimedia.org/wikipedia/commons/8/8d/President_Barack_Obama.jpg'
   # IMAGE_FILE_PATH = File.expand_path('../test.jpg', __FILE__)


    def index
        UserMailer.welcome_email(User.order(:id).last).deliver_now
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
        @all_groups = Group.all
        @userlat = request.location.latitude
        @userlon = request.location.longitude
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
