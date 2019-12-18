# frozen_string_literal: true

# home controller
class HomeController < ApplicationController
  def index
    @videos = Video.all
  end
end
