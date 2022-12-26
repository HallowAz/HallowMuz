require 'digest/sha1'
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if user_params[:password].length >= 6  
      if user_params[:password] == user_params[:passwordrepeat]
        new_user_params = user_params.permit(:login, :password, :firstname, :avatar)
        new_user_params[:avatar] = "base_avatar"
        new_user_params[:password] = Digest::SHA1.hexdigest(user_params[:password])
        @user = User.new(new_user_params)
        respond_to do |format|
          if @user.save
            session[:current_user_id] = @user.id
            format.html { redirect_to home_aut_path }
          else
            format.html { render :new, status: :unprocessable_entity }
            player_of
          end
        end
      else
        redirect_to new_user_path, notice: "Пароли не совпадают"
      end
    else
      redirect_to new_user_path, notice: "Пароль должен быть длинее 6 символов"
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if user_params[:password] == "" || user_params[:password].nil?
      new_user_params = user_params.permit(:login, :firstname, :avatar)
    else
      new_user_params = user_params.permit(:login, :password, :firstname, :avatar)
    end
    if new_user_params[:password].nil? || new_user_params[:password].length > 6   
      if new_user_params[:avatar].nil? || new_user_params[:avatar].original_filename.match('.png') != nil
      new_user_params[:avatar] = new_user_params[:avatar].original_filename.delete('.png') unless new_user_params[:avatar].nil?
        respond_to do |format|
          if @user.update(new_user_params)
            unless new_user_params[:avatar].nil?
              File.open(Rails.root.join('public', 'avatars', user_params[:avatar].original_filename.gsub(' ', '_')), 'wb') do |file|
                file.write(user_params[:avatar].read)
              end
            end
            format.html { redirect_to user_url(@user), notice: "Данные были успешно изменены" }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to edit_user_path(@user), notice: 'Формат должен быть png'
      end
    else
      redirect_to edit_user_path(@user), notice: 'Пароль не может быть короче 6 символов'
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    reset_session
    redirect_to autorization_path, notice: "Вы успешно удалили страницу"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if session[:current_user_id] == params[:id].to_i
        @user = User.find(params[:id])
      else
        @user = User.find(session[:current_user_id])
        redirect_to home_aut_path
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:login, :password, :passwordrepeat, :firstname, :avatar)
    end
end
