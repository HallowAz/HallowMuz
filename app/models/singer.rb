class Singer < ApplicationRecord
    belongs_to :user, optional: true
    has_many :tracks
    has_many :songs, through: :tracks
    has_many :albums

    validates :name,  presence: true
    validates :name, format: {with: /\A[а-яА-Я0-9\w\s]+/}
    validates :name, uniqueness: true
end
