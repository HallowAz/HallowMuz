class HomeController < ApplicationController
  before_action :ident
  def home
    unless session[:current_user_id].nil?
      redirect_to home_aut_path
    end
  end

  def home_aut
    if session[:current_user_id].nil?
      redirect_to root_path
      return
    end
  end

  def profile
  end

  def library
    @music = HomeHelper.my_muz(@user[:library])
  end

  def search
    unless params[:str].length == 0 || params[:str].nil?
      @search_muz = HomeHelper.search_muz(params[:str].downcase)
    else
      redirect_to home_aut_path
    end
  end

  def adding
    @user[:library] << params[:song_id].to_i
    @user.save
  end

  def deleting
    unless params[:playlist_id]
      @user[:library].delete_at(@user[:library].length - 1 - params[:count].to_i)
      @user.save
    else
      @playlist = Playlist.find_by_id(params[:playlist_id])
      @playlist.songs.destroy(Song.find_by_id(params[:song_id].to_i))
      @playlist.save
    end
  end
  
  def load

  end

  def after_load
    song = params[:song]
    unless song.original_filename.match('.mp3\z').nil?
      unless song.nil? || params[:singer] == ""
        HomeHelper.save_file(song)
        new_song = Song.new(name: params[:song].original_filename.delete(".mp3"))
        singers = params[:singer].gsub(' ft. ', ', ').split(', ')
        singers.each do |singer|
          check_singer = Singer.find_by_name(singer)
          if check_singer.nil?
            new_singer = Singer.create!(name:singer)
            new_singer.songs << new_song
          else
            check_singer.songs << new_song
          end
        end
        new_song.save
        redirect_to load_path, notice: 'Загрузка выполнена успешно'
      else
        redirect_to load_path, notice: 'Вы не заполнили все условия'
      end
    else
        redirect_to load_path, notice: 'Формат должен быть mp3'
    end
  end

  def creating_playlist
  end

  def creating_playlist_after
    Playlist.create!(name: params[:name], user: @user)
    redirect_to library_path
  end

  def adding_playlist
  end

  def after_adding_playlist
    @playlist = Playlist.find_by_id(params[:playlist_id])
    @playlist.songs << Song.find_by_id(params[:song_id].to_i)
    @playlist.save
  end

  def edit_playlist
    @playlist = Playlist.find_by_id(params[:playlist_id])
  end

  def deleting_playlist
    Playlist.find_by_id(params[:playlist_id]).delete
    redirect_to library_path
  end
  private
  
  def ident
    @user = User.find_by(id:session[:current_user_id])
  end
end
