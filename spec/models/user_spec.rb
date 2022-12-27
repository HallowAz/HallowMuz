require 'rails_helper'

RSpec.describe User, type: :model do
    let(:valid_attributes) {
        {:login => Faker::Internet.email, :firstname => Faker::Internet.username, :password => Faker::Internet.password(min_length: 6)}
      }
    
      let(:invalid_attributes) {
        {:login => Faker::Internet.username, :firstname => Faker::Internet.username, :password => Faker::Internet.password}
      }
    
    describe 'create' do
    
        it 'valid params' do
            expect(User.new(valid_attributes).valid?).to eq(true)
        end

        it 'invalid params' do
            expect(User.new(invalid_attributes).valid?).to eq(false)
        end
    end
    
    describe 'taking' do
        it 'correct recording' do
            User.create!(valid_attributes)
            expect(User.take.login).to eq(valid_attributes[:login])
            expect(User.take.firstname).to eq(valid_attributes[:firstname])
        end
    end
    
    describe 'double putting' do
        it 'correct recording' do
            User.create!(valid_attributes)
            expect(User.new(valid_attributes).valid?).to eq(false) 
        end
    end

    describe 'relations' do
        let(:user){
            user = User.create!(valid_attributes)
            user.playlists.create!(name:"test - test")
            user
        }

        it 'correct adding songs' do
            expect(user.playlists.count).to eq(1)
        end

        it 'full deleting' do
            user.destroy
            expect(User.count).to eq(0)
            expect(Playlist.count).to eq(0)
        end
    end

end
