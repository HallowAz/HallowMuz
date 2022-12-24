class RemoveColumnFromSongs < ActiveRecord::Migration[7.0]
  def change
    remove_column :songs, :singer_id, :integer
  end
end
