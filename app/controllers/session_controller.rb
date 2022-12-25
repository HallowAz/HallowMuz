class SessionController < ApplicationController
  def autorization 
  end

  def checking
    User.all.map do |elem|
      if elem.login == params[:login] && elem.password == Digest::SHA1.hexdigest(params[:password])
          session[:current_user_id] = elem.id
          redirect_to home_aut_path
          return
      end
    end
    if session[:cuurent_user_id].nil?
      redirect_to autorization_path, notice: "Неверный логин или пароль"
      return
    end
  end

  def log_out
    session.delete(:current_user_id)
    @_current_user = nil
    redirect_to autorization_path, status: :see_other
  end

end
