class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    if params[:search]
      users = User.presented.search params[:search]
    else
      users = User.send params[:scope]
    end
    @users = users.page(params[:page]).decorate
  end

  def new
    @user_form = UserForm.new_with_model
  end

  def edit
    @user_form = UserForm.find_with_model(params[:id])
  end

  def create
    @user_form = UserForm.new_with_model
    @user_form.submit(params[:user])
    if @user_form.save
      redirect_to admin_users_path
    else
      render action: :new
    end
  end

  def update
    @user_form = UserForm.find_with_model params[:id]
    @user_form.submit(params[:user])
    if @user_form.save
      redirect_to edit_admin_user_path @user_form.model
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
