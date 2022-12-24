class Album < ApplicationRecord
    belongs_to :singer
    has_many :songs
end
