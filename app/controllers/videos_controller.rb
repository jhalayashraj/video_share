# frozen_string_literal: true

# videos controller
class VideosController < ApplicationController
  before_action :authenticate_user!, only: %I[new create]

  def index
    @videos = Video.all
  end

  def new
    @video = current_user.videos.build
  end

  def create
    @video = current_user.videos.build(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to root_path, notice: 'Video successfully shared.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def video_params
    params.require(:video).permit(:id, :title, :description, :user_id, :url,
                                  :video_id)
  end
end
