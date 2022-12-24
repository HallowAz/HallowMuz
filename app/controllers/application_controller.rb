class ApplicationController < ActionController::Base
  before_action :authenticate, only: [:profile, :library, :adding] 
    private
    def current_user
      @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
    end

    def authenticate
      unless session[:current_user_id]
        redirect_to autorization_path, notice: 'Сначала необходимо авторизоваться'
      end
    end
end
