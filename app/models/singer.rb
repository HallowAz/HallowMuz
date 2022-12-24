class Singer < ApplicationRecord
    belongs_to :user, optional: true
    has_many :tracks
    has_many :songs, through: :tracks
    has_many :albums
end
