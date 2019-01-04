class Api::V1::MessagingController < ApplicationController

  def create
    render json: MessagingInterface.quick_post(params[:username])
  end
end
