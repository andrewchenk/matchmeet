class UserMailer < ApplicationMailer
  default from: 'community@matchmeet.online'
  def welcome_email(user)
    @user = user
    sparkpost_payload(
      options: {
        open_tracking: true
      },
      campaign_id: "Recruiting campaign",
      description: "Welcome email",
      content: {
        headers: {
          "X-Custom-Header" => "custom header value"
        }
      }
    )
    @user.welcomed = true
    mail(to: @user.email, subject: "Welcome to MatchMeet!")
  end

  def create_email(user, group)
    @user = user
    @group = group
    sparkpost_payload(
      options: {
        open_tracking: true
      },
      campaign_id: "Group-building campaign",
      description: "Created event email",
      content: {
        headers: {
          "X-Custom-Header" => "custom header value"
        }
      }
    )
    mail(to: @user.email, subject: "Event confirmation")
  end

  def join_email(user, group)
    @user = user
    @group = group
    sparkpost_payload(
      options: {
        open_tracking: true
      },
      campaign_id: "Group-building campaign",
      description: "Joined event email",
      content: {
        headers: {
          "X-Custom-Header" => "custom header value"
        }
      }
    )
    mail(to: @user.email, subject: "Congrats on joining an event!")
  end

  def suggest_email(user)
    @user = user
    sparkpost_payload(
      options: {
        open_tracking: true
      },
      campaign_id: "Group-building campaign",
      description: "Recommendation email",
      content: {
        headers: {
          "X-Custom-Header" => "custom header value"
        }
      }
    )
    mail(to: @user.email, subject: "You might like this event coming up soon...")
  end
end
