class Video < ApplicationRecord
  ## Relationships
  belongs_to :user

  ## Callbacks
  before_save :save_video_information

  def save_video_information
    url = Yt::URL.new self.url
    self.video_id = url.id
    self.title = url.resource.title
    self.description = url.resource.description
  end
end
