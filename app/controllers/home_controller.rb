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
    @user[:library].delete_at(@user[:library].length - 1 - params[:count].to_i)
    @user.save
  end
  
  def load

  end

  def after_load
    song = params[:song]
    unless song.nil? || params[:singer] == ""
      File.open(Rails.root.join('public', 'music', song.original_filename.gsub(' ', '_')), 'wb') do |file|
        file.write(song.read)
      end
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
  end

  def creating_playlist
    
  end

  def creating_playlist_after
    
  end
  private
  
  def ident
    @user = User.find_by(id:session[:current_user_id])
  end
end
