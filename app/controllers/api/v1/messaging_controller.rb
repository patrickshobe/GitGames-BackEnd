class Api::V1::MessagingController < ApplicationController

  def create
    MessagingInterface.quick_post(params[:username])
  end
end
