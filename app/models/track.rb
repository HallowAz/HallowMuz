class Track < ApplicationRecord
    belongs_to :singer
    belongs_to :song
end
