class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.references :user, index: true
      t.string :url
      t.string :video_id

      t.timestamps
    end
  end
end
