class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :home, :reset_password]

  def new
    user = User.new
  end

  def create
    user = User.new(user_params)
    user.role = "user";
    if user.save
      render :json => user
    else
      render :status => 400, :json => user.errors
    end
  end

  def update
    current_user.update_attributes(user_params)
    if current_user.save
      render :json => current_user
    else
      errors = current_user.errors
      @current_user = User.find(session[:user_id])
      render :status => 400, :json => errors
    end
  end

  def reset_password
    user = User.where(:email => user_params.email).first
    if user
      new_password = User.generate_random_password(8)
      user.password = new_password
      user.password_confirmation = new_password
      if user.save
        PasswordResetMailer.password_reset(user, new_password).deliver
        return render :status => 200, :text => "done"
      else
        return render :status => 400, :json => errors
      end
    else
      return render :status => 200, :text => "done"
    end
  end

  private

  def user_params
    tmp = params.require(:user).permit(:name, :nick, :email, :number, :password, :password_confirmation)
    tmp[:password] = params[:password]
    tmp[:password_confirmation] = params[:password_confirmation]
    return tmp
  end
end
