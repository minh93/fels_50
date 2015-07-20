class Admin::UsersController < Admin::BaseController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_user, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.users.destroy.flash_success"
    else
      flash[:danger] = t "controllers.users.destroy.flash_danger"
    end
    redirect_to users_url
  end

  private
  def load_user
    @user = User.find params[:id] if User.exists? params[:id]
  end
end
