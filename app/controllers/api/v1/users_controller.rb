class Api::V1::UsersController < ApplicationController
  def index
    render json: UserQuery.execute_query(params[:username])
  end
end
