class DestroyAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_reference  :songs, :album
    remove_reference :albums, :singer
  end
end
