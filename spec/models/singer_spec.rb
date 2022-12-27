require 'rails_helper'

RSpec.describe Singer, type: :model do

    let(:valid_attributes) {
        {:name => Faker::Name.name}
    }
    
    let(:invalid_attributes) {
        {:name => ""}
    }
    
    describe 'create' do
    
        it 'valid params' do
            expect(Singer.new(valid_attributes).valid?).to eq(true)
        end

        it 'invalid params' do
            expect(Singer.new(invalid_attributes).valid?).to eq(false)
        end
    end
    
    describe 'taking' do
        it 'correct recording' do
            Singer.create!(valid_attributes)
            expect(Singer.take.name).to eq(valid_attributes[:name]) 
        end
    end
    
    describe 'double putting' do
        it 'correct recording' do
            Singer.create!(valid_attributes)
            expect(Singer.new(valid_attributes).valid?).to eq(false) 
        end
    end

    describe 'relations' do
        let(:singer){
            singer = Singer.create!(valid_attributes)
            singer.songs << Song.create!(name:"test - test")
            singer
        }

        it 'correct adding songs' do
            expect(singer.songs.count).to eq(1)
        end

        it 'full deleting' do
            singer.destroy
            expect(Singer.count).to eq(0)
            expect(Track.count).to eq(0)
        end
    end
end
