class Album < ApplicationRecord
    belongs_to :singer
    has_many :songs

    validates :name, :singer_id, presence: true

end
