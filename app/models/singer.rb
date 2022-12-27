class Singer < ApplicationRecord
    has_many :tracks, dependent: :destroy
    has_many :songs, through: :tracks
    validates :name,  presence: true
    validates :name, format: {with: /\A[а-яА-Я0-9\w\s',&A-Za-z]+/}
    validates :name, uniqueness: true
end
