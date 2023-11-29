# frozen_string_literal: true

class StoryIdeaMailer < ApplicationMailer
  # default to: User.where(" 'communicator' = ANY (roles)").pluck(:email)
  default to: 'tom.connolly@comcast.net'
  def story_idea_created(story_idea)
    @story_idea = story_idea
    @story_idea_id = story_idea.id
    @url = url_for(@story_idea)
    mail(subject: "There's a new posting for the church communications team.")
  end
end
