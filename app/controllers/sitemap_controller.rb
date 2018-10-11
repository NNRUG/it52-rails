class SitemapController < ApplicationController
  respond_to :xml

  def index
    @events = Event.published
    # @users = User.all
    @pages = HighVoltage.page_ids
  end
end
