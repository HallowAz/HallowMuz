class Playlist < ApplicationRecord
  belongs_to :user, optional: true
  has_many :playlist_tracks
  has_many :songs, through: :playlist_tracks
end
