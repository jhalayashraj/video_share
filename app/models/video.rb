# frozen_string_literal: true

# Video Model
class Video < ApplicationRecord
  ## Relationships
  belongs_to :user

  ## Validations
  validates :url, presence: true

  ## Callbacks
  validate :save_video_information

  def save_video_information
    url = Yt::URL.new self.url
    if url.kind.to_s == 'video'
      self.video_id = url.id
      self.title = url.resource.title
      self.description = url.resource.description
    else
      errors.add(:url, 'is invalid')
    end
  end
end
