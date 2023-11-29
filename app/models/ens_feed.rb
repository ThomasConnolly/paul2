# frozen_string_literal: true

# == Schema Information
#
# Table name: ens_feeds
#
#  id           :bigint           not null, primary key
#  title        :string
#  summary      :text
#  url          :string
#  published_at :datetime
#  guid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EnsFeed < ApplicationRecord
  class << self
    def self.update_from_feed(feed_url)
      xml = HTTParty.get(feed_url).body
      feed = Feedjira.parse(xml)
      feed.entries.each do |entry|
        next if exists?(guid: entry.id)

        create!(
          title: entry.title,
          summary: entry.summary,
          url: entry.url,
          published_at: entry.published,
          guid: entry.id
        )
      end
    end
  end
end
