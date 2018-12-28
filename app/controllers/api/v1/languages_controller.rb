class Api::V1::LanguagesController < ApplicationController
  def index
    render json: language_parser.get_data(params[:username])
  end

  private

  def language_parser
    LanguageParser.new
  end
end
