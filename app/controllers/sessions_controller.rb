class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue Exception => e
      debugger
      flash[:warning] = "There was an error while trying to authenticate you..."
    end

    redirect_to root_path
  end

  def update
    id = params[:id].to_i
    session[:id] = User::ROLES.has_key?(id) ? id : 0
    flash[:success] = "Your new role #{User::ROLES[id]} was set!"

    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "See you!"
    end

    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end
end
