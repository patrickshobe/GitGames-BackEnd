class Api::V1::CommitMessagesController < ApplicationController
  def index
    commit = CommitMessageParser.new
    commit.get_data(params[:username])
    render json: commit.word_count
  end

  private

end
