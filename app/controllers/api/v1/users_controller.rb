class Api::V1::UsersController < ApplicationController
  def index
    render json: user_query.query(params[:username])
  end

  private

  def user_query
    UserQuery.new
  end
end
