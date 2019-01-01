class Api::V1::CommitTimelinesController < ApplicationController

  def index
    render json: CommitTimelineParser.new.get_data(params["username"])
  end
end
