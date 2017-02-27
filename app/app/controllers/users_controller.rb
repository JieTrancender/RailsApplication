class UsersController < ApplicationController
  def new
      @user = User.new
  end

  def create
      @user = User.create(user_params)

      if @user.save
          redirect_to :users_login
      else
          render "new"
      end
  end

  def login
  end

  def verify
      @user = User.find_by(name: user_params[:name]).try(:authenticate, user_params[:password])

      if @user
          render plain: sprintf("Welcoem, %s", @user.name)
      else
          flash.now[:login_error]  ="Invalid user name or password"
          render "new"
      end
  end

  private
    def user_params
        #params.require(:user).permit(:name, :email, :password, :password_digest)
        params.require(:user).permit!
    end
end
