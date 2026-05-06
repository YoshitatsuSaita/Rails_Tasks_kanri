class UsersController < ApplicationController
  before_action :logged_in_user , only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_or_correct_user, only: :show
  
  def index
    @users = User.paginate(page: params[:page],per_page: 20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in? && !current_user.admin?
      flash[:success] = 'ログイン中です。'
      redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    if logged_in? && !current_user.admin?
      flash[:success] = 'ログイン中です。'
      redirect_to current_user
    end
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '削除しました。'
    redirect_to users_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
