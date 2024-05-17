class UsersController < ApplicationController
  before_action :set_user ,only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user ,only:[:index, :show, :edit, :update, :destroy]
  before_action :correct_user ,only:[:edit, :update]
  before_action :admin_user ,only: [:index, :destroy]
  before_action :admin_or_correct_user ,only: :show
 
  def index
    @users = User.paginate(page:params[:page], per_page:20)
  end
  
  def show; end

  def new
   # 管理者がユーザを作成することは可能
   if logged_in? && !current_user.admin?
    flash[:info] = "すでにログインしています。"
    redirect_to current_user
   end
   @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規作成に成功しました。'
      # 管理者が作成する場合は、作成したユーザでログインしないようにする
      if current_user.admin?
        redirect_to @user
      else
        log_in @user
      end
    else
      render :new
    end
  end
  
  def edit; end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success]="ユーザー情報を編集しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success]="ユーザーを削除しました。"
    redirect_to users_url
  end
      
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user=User.find_by(id:params[:id])
    end
    
    # applicationコントローラ定義のものを継承し上書き
    def correct_user
      # 勤怠アプリのときの条件に以下を追加
      # ・管理者とゲストユーザは自身の編集、更新をできないようにする
      if !current_user?(@user) || current_user.admin? || current_user?(User.find_by(email: "guest@email.com"))
        flash[:danger]="権限がありません。"
        redirect_to(root_url)
      end
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def admin_or_correct_user
      unless current_user?(@user) || current_user.admin?
       flash[:danger]="権限がありません。"
       redirect_to(root_url)
      end
    end
end
