# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to(@commentable, notice: 'Comment was successfully created.')
    else
      redirect_to(@commentable, alert: 'Error: Comment could not be created.')
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to(@commentable)
  end

  private

  def find_commentable
    params.each do |name, value|
      # Differentiate between parent models Eg.: post_id, story_idea_id
      return ::Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :submit)
  end
end
