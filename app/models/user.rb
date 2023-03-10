class User < ApplicationRecord
    has_many :playlists, dependent: :destroy
    validates :login, :password, presence: true
    validates :login, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
    validates :password, length: { minimum: 6 }
    validates :login, uniqueness: true
end
