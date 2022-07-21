class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      flash.now[:success] = "Weclome, #{user.name}!"
      render 'new', status: :ok
    else
      flash.now[:danger] = "Email and password combination not recognized."
      render 'new', status: :unauthorized
    end
  end

  def destroy
  end

  def login_params
    params.require(:session).permit(:email, :password)
  end
end
