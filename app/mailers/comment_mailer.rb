# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def new_comment(comment)
    @comment = comment
    @recipients = get_recipients(comment)
    mail(
      to: @recipients,
      subject: 'New comment for you on the church website'
    )
  end

  private

  def get_recipients(comment)
    case comment.commentable_type
    when 'Vnote'
      User.where(" 'vestry' = ANY (roles)").where.not(id: comment_user_id).pluck(:email)
    when 'Post'
      User.where.not(email: nil).pluck(:email)
    when 'StoryIdea'
      User.where(" 'communicator' = ANY (roles)").where.not(id: comment_user_id).pluck(:email)
    end
  end
end
