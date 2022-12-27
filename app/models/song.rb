class Song < ApplicationRecord
    has_many :tracks, dependent: :destroy
    has_many :singers, through: :tracks
    has_many :playlist_tracks, dependent: :destroy
    has_many :playlists, through: :playlist_tracks

    validates :name, presence: true 

    validates :name, format: {with: /\A[а-яА-Я0-9',A-Za-z&\s]+-\s[а-яА-Я0-9',A-Za-z&\s]+\z/}
end
