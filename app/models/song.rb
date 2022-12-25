class Song < ApplicationRecord
    has_many :tracks
    has_many :singers, through: :tracks
    belongs_to :album, optional: true
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks

    validates :name, presence: true 

    validates :name, format: {with: /\A[а-яА-Я0-9\w\s]+-\s[а-яА-Я0-9\w\s]+\z/}
end
