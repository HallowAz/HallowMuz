class ApplicationController < ActionController::Base
  before_action :authenticate, only: [:profile, :library, :adding] 
  before_action :set_user, only: [:profile, :library, :adding, :home_aut]
  private
    def current_user
      @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
    end

    def authenticate
      unless session[:current_user_id]
        redirect_to autorization_path, notice: 'Сначала необходимо авторизоваться'
        return
      end
    end

    def set_user
      @user = User.find_by_id(session[:current_user_id])
    end

    def player_on
      debugger
    end
end
