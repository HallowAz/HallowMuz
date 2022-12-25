class User < ApplicationRecord
    has_many :playlists
    validates :login, :password, presence: true
    validates :login, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
    validates :password, length: { in: 6..20 }
    validates :login, uniqueness: true
end
