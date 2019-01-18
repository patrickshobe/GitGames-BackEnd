class Api::V1::CommunityController < ApplicationController
  def index
    render json: CommunityQuery.execute_query(params[:username])
  end
end
