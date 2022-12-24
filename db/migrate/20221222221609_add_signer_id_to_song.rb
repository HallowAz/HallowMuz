class AddSignerIdToSong < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums, :singer
    add_reference :songs, :singer
    add_reference :songs, :album
  end
end
