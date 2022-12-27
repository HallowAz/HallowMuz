require 'rails_helper'

RSpec.describe Playlist, type: :model do
    let(:valid_attributes_user) {
        {:login => Faker::Internet.email, :firstname => Faker::Internet.username, :password => Faker::Internet.password(min_length: 6)}
    }
    
    let(:invalid_attributes) {
        {:name => ""}
      }
    
    let(:valid_attributes) do
        user = User.create!(valid_attributes_user)
        {:name => Faker::Internet.username, :user => User.last}
    end

    describe 'create' do
    
        it 'valid params' do
            expect(Playlist.new(valid_attributes).valid?).to eq(true)
        end

        it 'invalid params' do
            expect(Playlist.new(invalid_attributes).valid?).to eq(false)
        end
    end
    
    describe 'taking' do
        it 'correct recording' do
            Playlist.create!(valid_attributes)
            expect(Playlist.take.name).to eq(valid_attributes[:name]) 
        end
    end
    
    describe 'relations' do
        let(:playlist){
            playlist = Playlist.create!(valid_attributes)
            
            playlist.songs << Song.create!(name:"test - test")
            playlist
        }

        it 'correct adding songs' do
            expect(playlist.songs.count).to eq(1)
        end

        it 'full deleting' do
            playlist.destroy
            expect(Playlist.count).to eq(0)
            expect(PlaylistTrack.count).to eq(0)
        end

    end
end
