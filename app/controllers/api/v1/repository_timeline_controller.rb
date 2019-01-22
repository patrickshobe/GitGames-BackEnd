class Api::V1::RepositoryTimelineController < ApplicationController
  def index
    render json: repository_timeline_parser.get_data(params[:username])
  end

  private

  def repository_timeline_parser
    RepositoryTimelineParser.new
  end
end
