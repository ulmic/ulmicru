class Web::Admin::UsersController < Web::Admin::ApplicationController
  include Concerns::RegistrationWithLogs

  def index
    if params[:search]
      users = User.presented.search params[:search]
    else
      users = User.send params[:scope]
    end
    @users = users.page(params[:page]).decorate
  end

  def show
    @user = UserDecorator.decorate User.find(params[:id])
    get_registrations_with_logs @user.registrations
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
      @user_form.model.set_gender!
      redirect_to admin_users_path
    else
      render action: :new
    end
  end

  def update
    @user_form = UserForm.find_with_model params[:id]
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
