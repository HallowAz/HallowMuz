class Song < ApplicationRecord
    has_many :tracks
    has_many :singers, through: :tracks
    belongs_to :album, optional: true
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks
end
