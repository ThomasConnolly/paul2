# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @event = Event.last
    @ens_feed = EnsFeed.all.order('published_at DESC').limit(6)
    @worship = Link.find_by(event: 'worship')
    @bulletin = Link.find_by(event: 'bulletin')
    @wine = Link.find_by(event: 'wine_time')
    @coffee = Link.find_by(event: 'coffee')
    @evening_bible = Link.find_by(event: 'evening_bible')
    @pathway = Pathway.order('created_at ASC').last
    @vestry_meeting = Link.find_by(event: 'vestry_meeting')
  end

  def show
    @worship = Link.find_by(event: 'worship')
    @bulletin = Link.find_by(event: 'bulletin')
    @wine = Link.find_by(event: 'wine_time')
    @coffee = Link.find_by(event: 'coffee')
    @day_bible = Link.find_by(event: 'day_bible')
    @evening_bible = Link.find_by(event: 'evening_bible')
    @pathway = Pathway.order('created_at ASC').last
    @vestry_meeting = Link.find_by(event: 'vestry_meeting')
  end
end
