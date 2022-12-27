require 'rails_helper'

RSpec.describe Song, type: :model do
    let(:valid_attributes) {
        {:name => Faker::Music::RockBand.name + ' - ' + Faker::Music::RockBand.song}
    }
    
    let(:invalid_attributes) {
        {:name => Faker::Music::RockBand.name}
    }
    
    describe 'create' do
    
        it 'valid params' do
            expect(Song.new(valid_attributes).valid?).to eq(true)
        end

        it 'invalid params' do
            expect(Song.new(invalid_attributes).valid?).to eq(false)
        end
    end
    
    describe 'taking' do
        it 'correct recording' do
            p valid_attributes
            Song.create!(valid_attributes)
            expect(Song.take.name).to eq(valid_attributes[:name]) 
        end
    end
    
    
    describe 'relations' do
        let(:song){
            p valid_attributes
            song = Song.create!(valid_attributes)
            song.singers << Singer.create!(name:"test")
            song
        }

        it 'correct adding songs' do
            expect(song.singers.count).to eq(1)
        end

        it 'full deleting' do
            song.destroy
            expect(Song.count).to eq(0)
            expect(Track.count).to eq(0)
        end
    end

end
