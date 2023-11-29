# frozen_string_literal: true

class PostMailer < ApplicationMailer
  default to: User.all.pluck(:email)

  def post_created(post)
    @post = post
    @url = url_for(@post)
    mail(
      subject: "There's a new post on the parish website"
    )
  end
end
