class GroupsController < ApplicationController
    before_action :authenticate_user!

    def list
        if (User.order(:id).last.welcomed != true)
          UserMailer.welcome_email(User.order(:id).last).deliver_now
          # User.order(:id).last.welcomed = true
        end
        @groups = Group.all
        @user_lat = request.location.latitude
        @user_lon = request.location.longitude

        # compute best suggestion
        @users = User.all
        max = -1
        @maxG = nil
        for g in @groups
            if g.scoresstr.nil?
                g.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(",")
            end
            dot_sum = 0
            for u in @users
                if u.scoresstr.nil?
                    u.scoresstr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(",")
                end
                g_score = g.scoresstr.split(',').map(&:to_i)
                u_score = u.scoresstr.split(',').map(&:to_i)
                dot_product = g_score.map.with_index{ |x, i| g_score[i]*u_score[i]}
                dot_sum = dot_sum + dot_product.sum
                u.save!
            end

            if dot_sum > max
                max = dot_sum
                @maxG = g
            end
            g.save!
        end
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
        g.name = 'Tennis Robin Match'
        g.description = 'Come together and have a fun around of robin match of tennis games. It will be fun!'
        g.scoresstr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0].join(',')
        g.save!

        g1 = Group.new
        g1.name = 'Tea with Strangers'
        g1.description = 'What is more interesting than stories? Stories from strangers! Come have a cup of tea with us.'
        g1.scoresstr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0].join(',')
        g1.save!

        g2 = Group.new
        g2.name = 'Soccer Pick up game'
        g2.description = 'We are a group of super chill soccer players. Come join us!'
        g2.scoresstr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].join(',')
        g2.save!

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
