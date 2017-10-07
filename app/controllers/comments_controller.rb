class CommentsController < ApplicationController
before_action :set_group

def create  
  @comment = @group.comments.build(comment_params)
  @comment.user_id = current_user.id

  if @comment.save
    flash[:success] = "You commented the hell out of that post!"
    redirect_to group_path(@group)
  else
    flash[:alert] = "Check the comment form, something went horribly wrong."
    render root_path
  end
end

def destroy  
  @comment = @group.comments.find(params[:id])

  @comment.destroy
  flash[:success] = "Comment deleted :("
  redirect_to root_path
end  

private

def comment_params  
  params.require(:comment).permit(:content)
end

def set_group  
  @group = Group.find(params[:group_id])
end  
end
