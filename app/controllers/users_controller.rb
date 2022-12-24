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
    if user_params[:password] == user_params[:passwordrepeat]
      new_user_params = user_params.permit(:login, :password)
      @user = User.new(new_user_params)
      respond_to do |format|
        if @user.save
          session[:current_user_id] = @user.id
          format.html { redirect_to user_url(@user), notice: "Регистрация завершена успешно" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_path, notice: "Пароли не совпадают"
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    new_user_params = user_params.permit(:login, :password)
    respond_to do |format|
      if @user.update(new_user_params)
        format.html { redirect_to user_url(@user), notice: "Данные были успешно изменены" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "Вы успешно удалили страницу." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:login, :password, :passwordrepeat)
    end
end
