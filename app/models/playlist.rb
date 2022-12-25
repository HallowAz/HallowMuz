class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_tracks
  has_many :songs, through: :playlist_tracks

  validates :name, :user_id, presence: true
end
