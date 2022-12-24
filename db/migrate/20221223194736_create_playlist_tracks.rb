class CreatePlaylistTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_tracks do |t|
      t.belongs_to :playlist
      t.belongs_to :song
      t.timestamps
    end
  end
end
