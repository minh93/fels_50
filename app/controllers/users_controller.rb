class UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.users.create.flash_success",
        name: @user.name
      redirect_to @user
    else
      render :new
    end
  end

  def show
    if User.exists? params[:id]
      @user = User.find params[:id]
    else
      flash[:danger] = t "controllers.users.show.flash_danger"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
