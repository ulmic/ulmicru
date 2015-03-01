class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user_form = UserForm.new(@user)
  end

  def edit
    @user = User.find params[:id]
    @user_form = UserForm.new(@user)
  end

  def create
    @user = User.new
    @user_form = UserForm.new(@user)
    @user_form.submit(params[:user])
    if @user_form.save
      redirect_to admin_users_path
    else
      render action: :new
    end
  end

  def update
    @user = User.find params[:id]
    @user_form = UserForm.new(@user)
    @user_form.submit(params[:user])
    if @user_form.save
      redirect_to admin_users_path
    else
      render action: :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.remove
    redirect_to admin_users_path
  end
end
