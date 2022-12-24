class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.belongs_to :singer
      t.belongs_to :song
      t.timestamps
    end
  end
end
