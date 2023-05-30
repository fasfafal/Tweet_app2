class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="ユーザー登録が完了しました。"
      redirect_to users_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.update(user_params)
    flash[:notice] = "ユーザー情報を編集しました。"
    redirect_to users_path
  end

  def login_form
  end
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています。"
      @email = params[:email]
      @password = params[:password]
      render "login_form", status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
  private 
  def user_params
    params.require(:user).permit(:name, :email, :image_name, :password)
  end
end
