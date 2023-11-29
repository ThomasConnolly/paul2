# frozen_string_literal: true

module AnniversariesHelper
  def recent_anniversaries
    Anniversary.find_marriages_for(Time.zone.today - 7,
                                   Time.zone.today + 7).order(:marriage)
  end
end
